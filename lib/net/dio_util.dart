import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_redux_mall/net/base_header_interceptor.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef ErrorCodeCallBack = void Function(int code, String msg);
typedef SuccessCallBack = void Function(Map<String, dynamic> data);

class DioUtil {
  DioUtil._();

  static const String _BASE_URL = "http://dev.shop.liveniao.com/";

  static Dio get dioInstance {
    assert(() {
      if (_instance == null) {
        throw StateError('you need init it before use it');
      }
      return true;
    }());
    return _instance;
  }

  static Dio _instance;

  static init() async {
    assert(_instance == null);
    BaseOptions options = BaseOptions(
      baseUrl: _BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    _instance = Dio(options);
    var temporaryDirectory = await getTemporaryDirectory();
    _instance.interceptors
        .add(CookieManager(PersistCookieJar(dir: temporaryDirectory.path)));
    _instance.interceptors.add(LogInterceptor(responseBody: true));

    Map<String, String> headers = Map();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    if (token != null) {
      headers['token'] = token;
    }
    _instance.interceptors.add(BaseHeaderInterceptor(headers));
  }

  static void post<T>(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
    @required SuccessCallBack onSuccessCallBack,
    ErrorCodeCallBack onErrorCodeCallBack,
  }) {
    assert(_instance != null);
    Future<Response<Map<String, dynamic>>> response =
        _instance.post<Map<String, dynamic>>(path,
            data: data,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress);
    response.then((value) {
      processData(value, onSuccessCallBack, onErrorCodeCallBack);
    });
  }

  static void get<T>(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
    @required SuccessCallBack onSuccessCallBack,
    ErrorCodeCallBack onErrorCodeCallBack,
  }) {
    assert(_instance != null);
    Future<Response<Map<String, dynamic>>> response =
        _instance.get<Map<String, dynamic>>(path,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress);
    response.then((value) {
      processData(value, onSuccessCallBack, onErrorCodeCallBack);
    });
  }

  static void processData(
    Response<Map<String, dynamic>> response,
    SuccessCallBack onSuccessCallBack,
    ErrorCodeCallBack onErrorCodeCallBack,
  ) {
    assert(onSuccessCallBack != null);
    if (response.data['code'] == 200) {
      onSuccessCallBack(response.data['data']);
    } else {
      if (onErrorCodeCallBack != null) {
        onErrorCodeCallBack(response.data['code'], response.data['msg']);
      }
    }
  }
}
