import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_redux_mall/util/utils.dart';
import 'state.dart';
import 'action.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_redux_mall/net/dio_util.dart';
import 'package:flutter_redux_mall/net/api.dart';

Effect<LoginState> buildEffect() {
  return combineEffects(<Object, Effect<LoginState>>{
    LoginPageAction.onLogin: _onLogin,
    LoginPageAction.onThirdLogin: _onThirdLogin,
  });
}

_onLogin(Action action, Context<LoginState> ctx) async {
  String phone = action.payload['phone'];
  String password = action.payload['password'];
  if (!RegexUtil.isMobileExact(phone)) {
    showToast(ctx.context, '请输入正确的手机号码');
    return true;
  }
  if (password.length < 6 || password.length > 20) {
    showToast(ctx.context, '密码应该是6-20位字母、数字或符号和密码');
    return true;
  }
  DioUtil.dioInstance.post<Object>(
    LOGIN,
    data: {'mobile': phone, 'password': password},
  ).then((value) {

  });
}

_onThirdLogin(Action action, Context<LoginState> ctx) {
  String type = 'QQ';
  assert(action.payload is int);
  switch (action.payload) {
    case 0:
      type = 'QQ';
      break;
    case 1:
      type = 'wechat';
      break;
    case 2:
      type = 'sina';
      break;
  }
  showToast(ctx.context, type);
}
