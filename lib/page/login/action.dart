import 'package:fish_redux/fish_redux.dart';

enum LoginPageAction {
  onLogin, onThirdLogin
}

class LoginPageActionCreator {
  static Action onLoginAction(String phone, String password) =>
      Action(LoginPageAction.onLogin,
          payload: {'phone': phone, 'password': password});

  /// 0 QQ    1 微信   2 微博
  static Action onThirdLogin(int type) =>
      Action(LoginPageAction.onThirdLogin,
          payload: type);
}
