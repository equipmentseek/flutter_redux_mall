import 'package:fish_redux/fish_redux.dart';

class HomeState extends Cloneable<HomeState>{
  @override
  HomeState clone() {
    return HomeState();
  }
}