import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tool_core/models/topic.dart';
import 'package:tool_core/repositories/all.dart';

part 'practice_state.dart';

class PracticeCubit extends Cubit<PracticeState> {
  final IUserRepository userRepository;
  PracticeCubit(this.userRepository) : super(PracticeInitial());

  Future<void> fetchTopics() async {
    emit(PracticeLoading());
    final response = await userRepository.getTopics();
    if (response.isSuccess) {
      emit(PracticeLoaded(response.data!));
    } else {
      emit(PracticeError('Failed to load topics'));
    }
  }
}
