import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gem_speak/core/auth/bloc/auth_bloc.dart';
import 'package:gem_speak/locator.dart';
import 'package:tool_core/models/progress_challenge.dart';
import 'package:tool_core/models/summary_learning.dart';
import 'package:tool_core/models/top_mistake.dart';
import 'package:tool_core/repositories/i_user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final IUserRepository userRepository;

  HomeCubit(this.userRepository) : super(HomeState.initial());

  void init() async {
    final userId = (getIt<AuthBloc>().state as AuthAuthenticated).userAuth.id;
    await Future.wait([
      fetchSummary(userId),
      fetchProgressChallenges(userId),
      fetchTopMistakes(userId),
    ]);
  }

  Future<void> fetchSummary(String userId) async {
    try {
      emit(state.copyWith(isLoadingSummary: true));
      final response = await userRepository.getSummary(userId: userId);
      if (response.isSuccess) {
        emit(
          state.copyWith(
            summaryLearning: response.data!,
            isLoadingSummary: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: 'Failed to fetch summary',
            isLoadingSummary: false,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoadingSummary: false));
    }
  }

  Future<void> fetchProgressChallenges(String userId) async {
    try {
      emit(state.copyWith(isLoadingProgressChallenges: true));
      final response = await userRepository.getProgress(userId: userId);
      if (response.isSuccess) {
        emit(
          state.copyWith(
            progressChallenges: response.data!,
            isLoadingProgressChallenges: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: 'Failed to fetch progress challenges',
            isLoadingProgressChallenges: false,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          isLoadingProgressChallenges: false,
        ),
      );
    }
  }

  Future<void> fetchTopMistakes(String userId) async {
    try {
      emit(state.copyWith(isLoadingTopMistakes: true));
      final response = await userRepository.getTopMistakes(userId: userId);
      if (response.isSuccess) {
        emit(
          state.copyWith(
            topMistake: response.data!,
            isLoadingTopMistakes: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: 'Failed to fetch top mistakes',
            isLoadingTopMistakes: false,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(errorMessage: e.toString(), isLoadingTopMistakes: false),
      );
    }
  }
}
