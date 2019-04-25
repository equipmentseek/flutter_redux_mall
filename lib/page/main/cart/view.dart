import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'state.dart';

Widget buildView(
    CartState state,
    Dispatch dispatch,
    ViewService viewService,
    ) {
  return Center(child: Text('cart'));
}