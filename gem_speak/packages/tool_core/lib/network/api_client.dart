import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tool_core/config/core_constant.dart';
import 'package:tool_core/enum/app_env.dart';
import 'package:tool_core/error/app_error_handler.dart';
import 'package:tool_core/network/api_interceptor.dart';

class ApiClient {
  late Dio _dio;

  ApiClient(AppEnv env, {String? baseUrl}) {
    final dioOptions = BaseOptions();
    dioOptions.connectTimeout = CoreConstant.timeout;
    dioOptions.sendTimeout = CoreConstant.timeout;
    dioOptions.receiveTimeout = CoreConstant.timeout;
    dioOptions.responseType = ResponseType.json;
    dioOptions.contentType = Headers.jsonContentType;

    if (baseUrl != null) {
      dioOptions.baseUrl = baseUrl;
    }

    _dio = Dio(dioOptions);
    _dio.interceptors.add(ApiInterceptor());

    if (env.isDevelopment) {
      _dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          responseHeader: true,
          responseBody: true,
          requestBody: true,
          compact: false,
        ),
      );
    }
  }

  updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  updateHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      throw toAppError(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      throw toAppError(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw toAppError(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw toAppError(e);
    }
  }
}
