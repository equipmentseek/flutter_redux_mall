import 'package:fish_redux/fish_redux.dart';

class DemoState extends Cloneable<DemoState> {
  int pressCount;

  @override
  DemoState clone() {
    return DemoState()..pressCount = pressCount;
  }
}

DemoState initState(Object params) {
  return DemoState()..pressCount = 0;
}
