import 'package:tool_core/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  @override
  Future<bool> isAuthenticated() async {
    await Future.delayed(const Duration(seconds: 2));
    return false;
  }

  @override
  Future<void> login() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
