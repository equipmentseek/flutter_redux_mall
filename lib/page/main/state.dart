import 'package:fish_redux/fish_redux.dart';
import 'cart/state.dart';
import 'category/state.dart';
import 'home/state.dart';
import 'mine/state.dart';

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

class HomeConnector extends ConnOp<MainState, HomeState>{

  @override
  HomeState get(MainState state) {
    return HomeState();
  }

  @override
  void set(MainState state, HomeState subState) {

  }
}

class CategoryConnector extends ConnOp<MainState, CategoryState>{

  @override
  CategoryState get(MainState state) => CategoryState();

  @override
  void set(MainState state, CategoryState subState) {

  }
}

class CartConnector extends ConnOp<MainState, CartState>{

  @override
  CartState get(MainState state) => CartState();

  @override
  void set(MainState state, CartState subState) {

  }
}

class MineConnector extends ConnOp<MainState, MineState>{

  @override
  MineState get(MainState state) => MineState();

  @override
  void set(MainState state, MineState subState) {

  }
}