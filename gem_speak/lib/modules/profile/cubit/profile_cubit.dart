import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gem_speak/core/auth/bloc/auth_bloc.dart';
import 'package:gem_speak/locator.dart';
import 'package:tool_core/models/user_answers.dart';
import 'package:tool_core/repositories/i_user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final IUserRepository _userRepository;
  ProfileCubit(this._userRepository) : super(ProfileInitial());

  Future<void> fetchUserAnswers() async {
    emit(ProfileLoading());
    final userId = (getIt<AuthBloc>().state as AuthAuthenticated).userAuth.id;
    final response = await _userRepository.getAllUserAnswers(userId: userId);

    if (response.isSuccess) {
      emit(ProfileLoaded(response.data!));
    } else {
      emit(ProfileError('Failed to load user answers'));
    }
  }
}
