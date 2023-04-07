import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../core/domain/managers/http_manager.dart';

class HttpDioManager implements HttpManager {
  HttpDioManager() {
    _dio = Dio();

    if (!kReleaseMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      );
    }
  }

  late Dio _dio;

  @override
  Future<HttpResponse> get(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) {
    return _solve(
      () => _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: headers,
        ),
      ),
    );
  }

  @override
  Future<HttpResponse> post(
    String url, {
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) {
    return _solve(
      () => _dio.post(
        url,
        data: requestBody,
        queryParameters: queryParams,
        options: Options(
          headers: headers,
        ),
      ),
    );
  }

  Future<HttpResponse> _solve(
    Future<Response<dynamic>> Function() jobRequest,
  ) async {
    final Future<Response> req = jobRequest();
    try {
      final Response response = await req;
      return HttpResponse(
        statusCode: response.statusCode ?? 0,
        data: response.data,
      );
    } catch (error) {
      if (error is DioError) {
        throw HttpFailure(
          error.response?.statusCode,
          error.response?.data,
        );
      }
      rethrow;
    }
  }
}
