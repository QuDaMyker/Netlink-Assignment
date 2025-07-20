part of 'check_prounciation_cubit.dart';

class CheckProunciationState extends Equatable {
  final bool isRecording;
  final String? recordingPath;
  final String? errorMessage;
  final PronunciationAssessmentAzureRes? assessment;
  final int currentIndexQuestion;
  final bool isLastQuestion;
  final bool isCheckingPronunciation;
  final bool isSendingAudio;
  final bool isPlayingAudio;
  final Duration? recordingDuration;
  const CheckProunciationState({
    this.isRecording = false,
    this.recordingPath,
    this.errorMessage,
    this.assessment,
    this.isCheckingPronunciation = false,
    this.currentIndexQuestion = 0,
    this.isSendingAudio = false,
    this.isLastQuestion = false,
    this.recordingDuration,
    this.isPlayingAudio = false,
  });

  @override
  List<Object> get props => [
    isRecording,
    recordingPath ?? '',
    errorMessage ?? '',
    assessment ?? '',
    isCheckingPronunciation,
    currentIndexQuestion,
    isLastQuestion,
    isSendingAudio,
    recordingDuration ?? Duration.zero,
    isPlayingAudio,
  ];

  CheckProunciationState copyWith({
    String? recordingPath,
    String? errorMessage,
    PronunciationAssessmentAzureRes? assessment,
    GeminiFeedback? gemeniFeedback,
    Duration? recordingDuration,
    int? currentIndexQuestion,
    bool? isCheckingPronunciation,
    bool? isLastQuestion,
    bool? isSendingAudio,
    bool? isRecording,
    bool? isPlayingAudio,
  }) {
    return CheckProunciationState(
      isPlayingAudio: isPlayingAudio ?? false,
      recordingDuration: recordingDuration ?? this.recordingDuration,
      isSendingAudio: isSendingAudio ?? this.isSendingAudio,
      isRecording: isRecording ?? this.isRecording,
      recordingPath: recordingPath ?? this.recordingPath,
      errorMessage: errorMessage ?? this.errorMessage,
      assessment: assessment ?? this.assessment,
      isCheckingPronunciation:
          isCheckingPronunciation ?? this.isCheckingPronunciation,
      currentIndexQuestion: currentIndexQuestion ?? this.currentIndexQuestion,
      isLastQuestion: isLastQuestion ?? this.isLastQuestion,
    );
  }

  CheckProunciationState resetToNextQuestion() {
    return CheckProunciationState(
      isRecording: false,
      recordingPath: null,
      errorMessage: null,
      assessment: null,
      isCheckingPronunciation: false,
      currentIndexQuestion: currentIndexQuestion + 1,
      isLastQuestion: false,
      isSendingAudio: false,
      recordingDuration: null,
    );
  }

  CheckProunciationState reset() {
    return CheckProunciationState(
      isRecording: false,
      recordingPath: null,
      errorMessage: null,
      assessment: null,
      isCheckingPronunciation: false,
      currentIndexQuestion: currentIndexQuestion,
      isLastQuestion: false,
      isSendingAudio: false,
      recordingDuration: null,
    );
  }
}
