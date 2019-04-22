import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void showToast(BuildContext context, String msg,
    {int duration = 1,
    int gravity = 0,
    Color backgroundColor = const Color(0xAA000000),
    Color textColor = Colors.white,
    double backgroundRadius = 20}) {
  Toast.show(msg, context,
      duration: duration,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      backgroundRadius: backgroundRadius);
}
