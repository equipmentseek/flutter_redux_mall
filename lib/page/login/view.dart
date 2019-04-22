import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_mall/constant/colors.dart';
import 'package:flutter_redux_mall/constant/text_styles.dart';
import 'package:flutter_redux_mall/custom_widget/app_bar.dart';
import 'package:flutter_redux_mall/r.dart';
import 'package:flutter_redux_mall/util/input_formatter.dart';
import 'state.dart';
import 'action.dart';

TextEditingController _phoneController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

Widget buildView(LoginState state, Dispatch dispatch, ViewService viewService) {
  _phoneController.text = state.phone;
  _passwordController.text = state.password;
  return Scaffold(
    appBar: TitleBar(
      '登录',
      subtitle: '注册',
    ),
    body: ListView(
      padding: EdgeInsets.all(15.0),
      children: <Widget>[
        SizedBox.fromSize(
          size: Size.fromHeight(15.0),
        ),
        Text(
          '手机号码',
          style: c333_14,
        ),
        TextField(
          controller: _phoneController,
          style: c333_14,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: '请输入手机号码',
            hintStyle: c999_14,
          ),
          inputFormatters: [NumberTextInputFormatter.getInstance()],
        ),
        SizedBox.fromSize(
          size: Size.fromHeight(15.0),
        ),
        Text(
          '密码',
          style: c333_14,
        ),
        TextField(
          controller: _passwordController,
          obscureText: true,
          style: c333_14,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: '6-20位字母、数字或符号和密码',
            hintStyle: c999_14,
          ),
        ),
        SizedBox.fromSize(
          size: Size.fromHeight(30.0),
        ),
        SizedBox.fromSize(
          child: RaisedButton(
            onPressed: () {
              dispatch(LoginPageActionCreator.onLoginAction(
                  _phoneController.text, _passwordController.text));
            },
            child: Text(
              '登录',
              style: white_14,
            ),
            color: colorPrimary,
          ),
          size: Size.fromHeight(50.0),
        ),
        Align(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
            child: Text(
              '忘记密码？',
              style: c999_14,
            ),
          ),
          alignment: Alignment.centerRight,
        ),
        SizedBox.fromSize(
          size: Size.fromHeight(200.0),
        ),
        Align(
          child: Text(
            '第三方登录',
            style: c999_14,
          ),
        ),
        Row(
          children: <Widget>[
            buildThirdLoginWidget(0, () {
              dispatch(LoginPageActionCreator.onThirdLogin(0));
            }),
            buildThirdLoginWidget(1, () {
              dispatch(LoginPageActionCreator.onThirdLogin(1));
            }),
            buildThirdLoginWidget(2, () {
              dispatch(LoginPageActionCreator.onThirdLogin(2));
            }),
          ],
        ),
      ],
    ),
  );
}

Widget buildThirdLoginWidget(int flag, GestureTapCallback onTap) {
  var iconSize = 40.0;
  var imgPath;
  var des;
  switch (flag) {
    case 0:
      imgPath = R.imagesLoginQqPng;
      des = 'QQ';
      break;
    case 1:
      imgPath = R.imagesLoginWeixinPng;
      des = '微信';
      break;
    default:
      imgPath = R.imagesLoginSinaPng;
      des = '微博';
      break;
  }
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            Image.asset(
              imgPath,
              width: iconSize,
              height: iconSize,
            ),
            SizedBox.fromSize(
              size: Size.fromHeight(8.0),
            ),
            Text(
              des,
              style: c333_14,
            )
          ],
        ),
      ),
    ),
  );
}
