import 'package:dio/dio.dart';

class BaseHeaderInterceptor extends Interceptor {
  Map<String, String> _headers;

  BaseHeaderInterceptor(Map<String, String> headers) : _headers = Map() {
    if (headers != null && headers.isNotEmpty) {
      _headers.addAll(headers);
    }
  }

  void addHeader(String key, String value) {
    _headers[key] = value;
  }

  void removeHeader(String key) {
    _headers.remove(key);
  }

  @override
  onRequest(RequestOptions options) {
    options.headers.addAll(_headers);
    return options;
  }
}
