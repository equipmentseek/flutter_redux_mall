import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'state.dart';
import 'action.dart';

Widget buildView(
  HomeState state,
  Dispatch dispatch,
  ViewService viewService,
) {
  return Center(
      child: IntrinsicHeight(
    child: Column(
      children: <Widget>[
        Text('home'),
        RaisedButton(
          onPressed: () => dispatch(HomeActionCreator.onLoginAction()),
          child: Text('跳转到登录界面'),
        ),
        RaisedButton(
          onPressed: () => dispatch(HomeActionCreator.onDemoAction()),
          child: Text('跳转到dmeo界面'),
        ),
      ],
    ),
  ));
}
