import 'package:fish_redux/fish_redux.dart';

enum MainAction {
  onTabChange,
}

class MainActionCreator{
  static Action onTabChangeAction(int index) => Action(MainAction.onTabChange, payload: index);
}
