import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DioUtil {
  DioUtil._();

  static const String _BASE_URL = "http://dev.shop.liveniao.com/";

  static Dio get dioInstance {
    assert((){
      if(_instance == null){
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
  }
}
