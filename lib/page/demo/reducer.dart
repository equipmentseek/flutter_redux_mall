import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'action.dart';

Reducer<DemoState> buildReducer() {
  return asReducer(<Object, Reducer<DemoState>>{
    DemoAction.onPress: onPressReducer,
    DemoAction.onReduce: onReduceReducer,
    DemoAction.onStep: onStepReducer,
  });
}

DemoState onPressReducer(DemoState state, Action action) {
  int pressCount = action.payload ?? state.pressCount + 1;
  return state.clone()..pressCount = pressCount;
}

DemoState onReduceReducer(DemoState state, Action action) {
  int pressCount = action.payload ?? state.pressCount - 1;
  return state.clone()..pressCount = pressCount;
}

DemoState onStepReducer(DemoState state, Action action) {
  print('onStepReducer------');
  return state;
}
