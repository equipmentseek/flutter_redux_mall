import 'package:fish_redux/fish_redux.dart';

class CartState extends Cloneable<CartState>{
  @override
  CartState clone() {
    return CartState();
  }
}