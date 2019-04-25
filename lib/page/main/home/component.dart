import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'view.dart';
import 'effect.dart';

class HomeComponent extends Component<HomeState>{

  HomeComponent(): super(
    view : buildView,
    effect : buildEffect(),
  );
}