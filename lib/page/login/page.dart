import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_redux_mall/page/login/reducer.dart';
import 'view.dart';
import 'state.dart';
import 'effect.dart';

class LoginPage extends Page<LoginState, Map<String, String>> {
  LoginPage() : super(
    initState : initState,
    view: buildView,
    reducer : buildReducer(),
    effect : buildEffect(),
  );
}
