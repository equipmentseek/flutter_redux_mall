import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'action.dart';
import 'package:flutter/material.dart';

Effect<DemoState> buildEffect() {
  return combineEffects(<Object, SubEffect<DemoState>>{
    DemoAction.onStep: _onStep,
  });
}

///返回false时，action可以继续被reducer处理
_onStep(Action action, Context<DemoState> ctx) {
  Navigator.of(ctx.context).pushNamed('login',
      arguments: {'phone': '13163751865', 'password': '123456'});
}
