import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_redux_mall/net/base_header_interceptor.dart';
import 'package:flutter_redux_mall/util/utils.dart';
import 'package:flutter_redux_mall/vo/login_vo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'state.dart';
import 'action.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_redux_mall/net/dio_util.dart';
import 'package:flutter_redux_mall/net/api.dart';
import 'package:flutter/material.dart';

Effect<LoginState> buildEffect() {
  return combineEffects(<Object, Effect<LoginState>>{
    LoginPageAction.onLogin: _onLogin,
    LoginPageAction.onThirdLogin: _onThirdLogin,
  });
}

_onLogin(Action action, Context<LoginState> ctx) {
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
  DioUtil.post(
    LOGIN,
    data: {'mobile': phone, 'password': password},
    onSuccessCallBack: (value){
      LoginVo data = LoginVo.fromJson(value);
      DioUtil.dioInstance.interceptors.forEach((interceptor){
        if(interceptor is BaseHeaderInterceptor){
          interceptor.addHeader('token', data.token);
        }
      });
      SharedPreferences.getInstance().then((preferences){
        preferences.setInt('user_id', data.userInfo.userId);
      });
      SharedPreferences.getInstance().then((preferences){
        preferences.setString('token', data.token);
      });
      Navigator.popAndPushNamed(ctx.context, '/main');
    },
  );
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
