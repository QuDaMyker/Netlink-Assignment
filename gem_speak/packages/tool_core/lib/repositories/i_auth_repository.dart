abstract class IAuthRepository {
  Future<bool> isAuthenticated();
  Future<void> login();
  Future<void> logout();
}
