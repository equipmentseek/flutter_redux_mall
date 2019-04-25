import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'view.dart';
import 'reducer.dart';
import 'home/component.dart';
import 'category/component.dart';
import 'cart/component.dart';
import 'mine/component.dart';

class MainPage extends Page<MainState, dynamic> {
  MainPage()
      : super(
          initState: initState,
          view: buildView,
          reducer: buildReducer(),
          dependencies: Dependencies(slots: <String, Dependent<MainState>>{
            'home': HomeComponent().asDependent(HomeConnector()),
            'category': CategoryConnector() + CategoryComponent(),
            'cart': CartConnector() + CartComponent(),
            'mine': MineConnector() + MineComponent(),
          }),
        );
}
