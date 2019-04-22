import 'package:fish_redux/fish_redux.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///创建应用的默认页面改造成redux结构
class DemoPage extends Page<DemoState, Object> {
  DemoPage()
      : super(
          initState: initState,
          view: buildView,
          reducer: buildReducer(),
          effect: buildEffect(),
        );
}
