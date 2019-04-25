import 'package:fish_redux/fish_redux.dart';

class MineState extends Cloneable<MineState>{
  @override
  MineState clone() {
    return MineState();
  }
}