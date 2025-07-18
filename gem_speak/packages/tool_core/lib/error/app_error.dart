class AppError implements Exception {
  bool? refreshTokenPending;
  String? message;
  int? errorCode;
  int? status;
  dynamic error;

  AppError({
    this.refreshTokenPending,
    this.message,
    this.errorCode,
    this.status,
    this.error,
  });

  AppError.fromJson(Map<String, dynamic> json)
    : message = AppError.parseMessage(json),
      status = json['status'],
      errorCode = json['errorCode'];

  static String parseMessage(Map<String, dynamic> json) {
    String? message = json['message'];
    if (message == null) {
      if (json['error'] != null) {
        if (json['path'] != null) {
          message = 'Path ${json['path']} : ${json["error"]}';
        } else {
          message = json['error'];
        }
      } else {
        message = "Unknown error";
      }
    }
    return message!;
  }

  StackTrace? _stackTrace;

  set stackTrace(StackTrace? stackTrace) => _stackTrace = stackTrace;

  StackTrace? getStackTrace() => _stackTrace;

  @override
  String toString() {
    var msg =
        'BuiltLabError: message: [$message], errorCode: $errorCode, status: $status';
    if (_stackTrace != null) {
      msg += '\n$_stackTrace';
    }
    return msg;
  }
}
