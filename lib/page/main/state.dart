import 'package:fish_redux/fish_redux.dart';

class MainState extends Cloneable<MainState> {
  int tabIndex;

  MainState({this.tabIndex});

  @override
  MainState clone() {
    MainState newState = MainState();
    newState.tabIndex = tabIndex;
    return newState;
  }
}

MainState initState(params) {
  return MainState(tabIndex: 0);
}
