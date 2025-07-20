import 'package:tool_core/models/user_auth.dart';
import 'package:tool_core/network/api_response.dart';

abstract class IAuthRepository {
  Future<ApiResponse<UserAuth>> login({
    required String email,
    required String password,
  });
  Future<ApiResponse<String>> getNewAccessToken({required String refreshToken});

  Future<ApiResponse<bool>> validateAccessToken({required String accessToken});
}
