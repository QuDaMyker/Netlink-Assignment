part of 'review_answer_cubit.dart';

sealed class ReviewAnswerState extends Equatable {
  const ReviewAnswerState();

  @override
  List<Object> get props => [];
}

final class ReviewAnswerInitial extends ReviewAnswerState {}

final class ReviewAnswerLoading extends ReviewAnswerState {}

final class ReviewAnswerLoaded extends ReviewAnswerState {
  final AudioAssessment assessment;

  const ReviewAnswerLoaded(this.assessment);

  @override
  List<Object> get props => [assessment];
}

final class ReviewAnswerError extends ReviewAnswerState {
  final String message;

  const ReviewAnswerError(this.message);

  @override
  List<Object> get props => [message];
}
