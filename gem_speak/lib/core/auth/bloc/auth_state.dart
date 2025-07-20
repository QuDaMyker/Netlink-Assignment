part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserAuth userAuth;

  String get accessToken => userAuth.accessToken;

  const AuthAuthenticated({required this.userAuth});

  @override
  List<Object> get props => [userAuth];
}

class AuthUnauthenticated extends AuthState {
  final String? message;

  const AuthUnauthenticated({this.message});

  @override
  List<Object> get props => [message ?? ''];
}
