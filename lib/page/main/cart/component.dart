import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'view.dart';

class CartComponent extends Component<CartState> {
  CartComponent()
      : super(
          view: buildView,
        );
}
