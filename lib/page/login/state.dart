import 'package:fish_redux/fish_redux.dart';

class LoginState extends Cloneable<LoginState> {
  String phone;
  String password;

  @override
  LoginState clone() {
    return LoginState()
      ..phone = phone
      ..password = password;
  }

  LoginState({this.phone, this.password});
}

LoginState initState(Map<String, String> param) {
  return LoginState(phone: param['phone'], password: param['password']);
}
