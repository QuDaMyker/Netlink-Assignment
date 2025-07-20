import 'package:dio/dio.dart';

class ApiResponse<T> {
  bool? success;
  T? data;
  DateTime? timestamp;

  bool get isSuccess => success ?? false;

  ApiResponse.success(this.data, dynamic res) {
    success = res['success'];
    timestamp =
        res['timestamp'] != null
            ? DateTime.parse(res['timestamp'])
            : DateTime.now();
  }

  ApiResponse.failed(dynamic error) {
    if (error is DioException) {
      success = false;
      data = error.response?.data ?? 'Unknown error';
      timestamp = DateTime.now();
    } else {
      success = false;
      timestamp = DateTime.now();
    }
  }
}
