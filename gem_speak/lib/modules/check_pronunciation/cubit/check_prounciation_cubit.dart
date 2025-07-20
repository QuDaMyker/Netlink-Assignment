import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gem_speak/utils/services/audio/audio_service.dart';
import 'package:gem_speak/utils/services/record/record_service.dart';
import 'package:gem_speak/utils/services/tts/tts_service.dart';
import 'package:tool_core/models/gemini_feedback.dart';
import 'package:tool_core/models/pronunciation_assessment_azure_res.dart';
import 'package:tool_core/models/topic.dart';
import 'package:tool_core/repositories/i_user_repository.dart';

part 'check_prounciation_state.dart';

class CheckProunciationCubit extends Cubit<CheckProunciationState> {
  final Topic topic;
  final IUserRepository userRepository;
  CheckProunciationCubit({required this.topic, required this.userRepository})
    : super(CheckProunciationState());

  void onClickNextQuestion() {
    if (state.currentIndexQuestion < topic.questions!.length - 1) {
      emit(state.resetToNextQuestion());
    } else {
      emit(state.copyWith(isLastQuestion: true));
    }
  }

  void onClickReadQuestion() {
    if (topic.questions![state.currentIndexQuestion].questionText == null) {
      return;
    }
    TtsService().speak(
      topic.questions![state.currentIndexQuestion].questionText!,
    );
  }

  Timer? _recordingTimer;

  void onClickRecordAudio() async {
    if (state.isRecording) {
      _recordingTimer?.cancel();
      final filePath = await RecordService().stopRecording();

      emit(
        state.copyWith(
          isRecording: false,
          recordingPath: filePath,
          errorMessage: '',
        ),
      );

      if (filePath != null) {
        await AudioService().init(filePath);
        emit(state.copyWith(recordingDuration: AudioService().duration));
        sendGetSTT();
      }
    } else {
      emit(state.copyWith(isRecording: true));
      await RecordService().startRecordingToFile();
      _recordingTimer = Timer(const Duration(seconds: 30), () async {
        if (state.isRecording) {
          final filePath = await RecordService().stopRecording();
          AudioService().init(filePath!);
          emit(
            state.copyWith(
              isRecording: false,
              recordingPath: filePath,
              recordingDuration: AudioService().duration,
            ),
          );
          sendGetSTT();
        }
      });
    }
  }

  void sendGetSTT() async {
    if (state.recordingPath != null) {
      emit(
        state.copyWith(
          isSendingAudio: true,
          isCheckingPronunciation: true,
          errorMessage: '',
        ),
      );
      final response = await userRepository
          .gemeniFeedBackAndPronunciationAssessment(
            audioFilePath: state.recordingPath!,
            questionId: topic.questions![state.currentIndexQuestion].id,
          );
      if (response.isSuccess) {
        final geminiFeedback = response.data!;
        emit(
          state.copyWith(
            gemeniFeedback: geminiFeedback,
            isCheckingPronunciation: false,
            assessment: geminiFeedback.pronunciationAssessment,
            isSendingAudio: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: 'Error sending audio for STT',
            isSendingAudio: false,
          ),
        );
      }
    }
  }

  Future<void> sendGetPronunciationAssessment({
    required String transcript,
  }) async {
    emit(state.copyWith(isCheckingPronunciation: true));
    if (state.recordingPath != null) {
      final response = await userRepository.checkPronunciation(
        audioFilePath: state.recordingPath!,
        text: transcript,
      );
      if (response.isSuccess) {
        final assessment = response.data!;
        emit(
          state.copyWith(
            assessment: assessment,
            isCheckingPronunciation: false,
            isSendingAudio: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: 'Error checking pronunciation',
            isCheckingPronunciation: false,
            isSendingAudio: false,
          ),
        );
      }
    }
  }

  void onClickPlayAudio() async {
    if (state.recordingPath != null) {
      emit(state.copyWith(isPlayingAudio: true));
      await AudioService().playAudio(state.recordingPath!);
      emit(state.copyWith(isPlayingAudio: false));
    }
  }

  void onClickSendAudioToCheck() {
    if (state.isSendingAudio) return;
    if (state.recordingPath != null) {
      sendGetSTT();
    }
  }

  void onClickBack() {
    if (state.isRecording) {
      RecordService().dispose();
    }
    if (state.isPlayingAudio) {
      AudioService().stopAudio();
    }
    emit(state.reset());
  }
}
