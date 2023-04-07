import 'package:flutter/foundation.dart';
import '../errors/errors.dart';

abstract class HttpManager {
  Future<HttpResponse> get(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  });
  Future<HttpResponse> post(
    String url, {
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  });
}

class HttpResponse {
  HttpResponse({
    required this.statusCode,
    required this.data,
  });
  final int statusCode;
  final dynamic data;

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
}

typedef HttpMapper<T> = T Function(dynamic);

extension HttpManagerEx on Future<HttpResponse> {
  Stream<T> handle<T>({required HttpMapper<T> mapper}) async* {
    try {
      final HttpResponse response = await this;
      if (response.isSuccess) {
        final T parsedObject = mapper(response.data);
        yield parsedObject;
      } else {
        if (response.statusCode == 404) {
          throw UrlAliasNotFound();
        }
        throw Exception('${response.statusCode} ${response.data}');
      }
    } catch (error) {
      debugPrint('HTTP ERROR: ${error.toString()}');
    }
  }
}
