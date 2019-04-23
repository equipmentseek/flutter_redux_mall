import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'action.dart';

Reducer<MainState> buildReducer() {
  return asReducer<MainState>(<Object, Reducer<MainState>>{
    MainAction.onTabChange : onTabChangeReducer,
  });
}

MainState onTabChangeReducer(MainState state, Action action){
  return state.clone()..tabIndex = action.payload;
}