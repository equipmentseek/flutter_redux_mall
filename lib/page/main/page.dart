import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'view.dart';
import 'reducer.dart';

class MainPage extends Page<MainState, dynamic> {
  MainPage()
      : super(
          initState: initState,
          view: buildView,
          reducer: buildReducer(),
        );
}
