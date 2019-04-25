import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'view.dart';

class CategoryComponent extends Component<CategoryState> {
  CategoryComponent()
      : super(
          view: buildView,
        );
}
