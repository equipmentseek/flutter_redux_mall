import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'action.dart';
import 'package:flutter/material.dart';

Effect<HomeState> buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    HomeAction.onToLogin: _onToLogin,
    HomeAction.onToDemo: _onToDemo,
  });
}

_onToLogin(Action action, Context<HomeState> ctx) {
  Navigator.pushNamed(ctx.context, '/login');
}

_onToDemo(Action action, Context<HomeState> ctx) {
  Navigator.pushNamed(ctx.context, '/demo');
}
