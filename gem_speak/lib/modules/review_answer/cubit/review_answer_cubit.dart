import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tool_core/models/audio_assessment.dart';
import 'package:tool_core/repositories/all.dart';

part 'review_answer_state.dart';

class ReviewAnswerCubit extends Cubit<ReviewAnswerState> {
  final IUserRepository _userRepository;
  ReviewAnswerCubit(this._userRepository) : super(ReviewAnswerInitial());

  Future<void> fetchAudioAssessment(String assessmentId) async {
    try {
      emit(ReviewAnswerLoading());
      final audioAssessment = await _userRepository.getAudioAssessmentById(
        audioAssessmentId: assessmentId,
      );
      if (audioAssessment.isSuccess) {
        emit(ReviewAnswerLoaded(audioAssessment.data!));
      } else {
        emit(ReviewAnswerError('Unknown error'));
      }
    } catch (e) {
      emit(ReviewAnswerError('Failed to load assessment'));
    }
  }
}
