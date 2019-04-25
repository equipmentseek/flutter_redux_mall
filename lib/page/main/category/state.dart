import 'package:fish_redux/fish_redux.dart';

class CategoryState extends Cloneable<CategoryState>{
  @override
  CategoryState clone() {
    return CategoryState();
  }
}