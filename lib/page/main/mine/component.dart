import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'view.dart';

class MineComponent extends Component<MineState> {
  MineComponent()
      : super(
          view: buildView,
        );
}
