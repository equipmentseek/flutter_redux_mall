import 'package:fish_redux/fish_redux.dart';

enum HomeAction { onToLogin, onToDemo }

class HomeActionCreator {
  static Action onLoginAction() => Action(HomeAction.onToLogin);

  static Action onDemoAction() => Action(HomeAction.onToDemo);
}
