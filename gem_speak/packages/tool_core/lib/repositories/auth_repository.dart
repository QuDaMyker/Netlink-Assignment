import 'package:tool_core/models/user_auth.dart';
import 'package:tool_core/network/api_client.dart';
import 'package:tool_core/network/api_enpoints.dart';
import 'package:tool_core/network/api_response.dart';
import 'package:tool_core/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final ApiClient _apiClient;
  AuthRepository(this._apiClient);

  @override
  Future<ApiResponse<String>> getNewAccessToken({
    required String refreshToken,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEnpoints.refreshToken,
        data: {'refresh_token': refreshToken},
      );
      final newAccessToken = response.data['data']['access_token'] as String;
      return ApiResponse.success(newAccessToken, response.data);
    } catch (e) {
      return ApiResponse.failed(e);
    }
  }

  @override
  Future<ApiResponse<UserAuth>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEnpoints.login,
        data: {'email': email, 'password': password},
      );
      final userAuth = UserAuth.fromJson(response.data['data']);
      return ApiResponse.success(userAuth, response.data);
    } catch (e) {
      return ApiResponse.failed(e);
    }
  }

  @override
  Future<ApiResponse<bool>> validateAccessToken({
    required String accessToken,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEnpoints.validateToken,
        data: {'access_token': accessToken},
      );
      return ApiResponse.success(response.data['data'], response.data);
    } catch (e) {
      return ApiResponse.failed(e);
    }
  }
}
