part of 'practice_cubit.dart';

sealed class PracticeState extends Equatable {
  const PracticeState();

  @override
  List<Object> get props => [];
}

final class PracticeInitial extends PracticeState {}

class PracticeLoading extends PracticeState {}

class PracticeLoaded extends PracticeState {
  final List<Topic> topics;

  const PracticeLoaded(this.topics);

  @override
  List<Object> get props => [topics];
}

class PracticeError extends PracticeState {
  final String message;

  const PracticeError(this.message);

  @override
  List<Object> get props => [message];
}
