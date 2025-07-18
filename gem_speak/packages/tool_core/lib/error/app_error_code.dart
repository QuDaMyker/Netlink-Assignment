abstract class AppErrorCode {
  static const int general = 2;
  static const int authentication = 10;
  static const int jwtTokenExpired = 11;
  static const int tenantTrialExpired = 12;
  static const int credentialsExpired = 15;
  static const int permissionDenied = 20;
  static const int invalidArguments = 30;
  static const int badRequestParams = 31;
  static const int itemNotFound = 32;
  static const int tooManyRequests = 33;
  static const int tooManyUpdates = 34;
}
