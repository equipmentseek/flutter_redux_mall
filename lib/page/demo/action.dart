import 'package:fish_redux/fish_redux.dart';

enum DemoAction { onPress, onReduce, onStep }

class DemoActionCreator {
  static Action onPressAction(int lastCount) {
    return Action(DemoAction.onPress, payload: lastCount + 1);
  }

  static Action onReduceAction(int lastCount) {
    return Action(DemoAction.onReduce, payload: lastCount - 1);
  }

  static Action onStepAction() {
    return Action(DemoAction.onStep);
  }
}
