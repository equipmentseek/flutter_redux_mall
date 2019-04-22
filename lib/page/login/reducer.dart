import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'action.dart';

Reducer<LoginState> buildReducer(){
  return asReducer(<Object, Reducer<LoginState>>{
  });
}