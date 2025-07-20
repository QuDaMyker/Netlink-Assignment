import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gem_speak/locator.dart';
import 'package:gem_speak/utils/services/user/_app_secure_storage.dart';
import 'package:tool_core/models/user_auth.dart';
import 'package:tool_core/network/api_client.dart';
import 'package:tool_core/repositories/i_auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;
  final AppSecureStorage appStorage;

  AuthBloc(this.authRepository, this.appStorage) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final userAuth = await appStorage.getUserAuth();
    if (userAuth != null) {
      final accessToken = userAuth.accessToken;
      final isValid = await authRepository.validateAccessToken(
        accessToken: accessToken,
      );
      if (isValid.isSuccess && isValid.data == true) {
        final apiClient = getIt<ApiClient>();
        apiClient.updateAccessToken(accessToken);
        emit(AuthAuthenticated(userAuth: userAuth));
      } else {
        emit(AuthUnauthenticated());
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final response = await authRepository.login(
        email: event.email,
        password: event.password,
      );
      if (response.isSuccess) {
        await appStorage.saveUserAuth(jsonEncode(response.data!.toJson()));
        emit(AuthAuthenticated(userAuth: response.data!));
      } else {
        emit(AuthUnauthenticated(message: 'Invalid email or password'));
      }
    } catch (e) {
      emit(AuthUnauthenticated(message: 'An error occurred'));
    }
  }

  Future<void> _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await appStorage.clear();
    emit(AuthUnauthenticated(message: 'You have been logged out'));
  }
}
