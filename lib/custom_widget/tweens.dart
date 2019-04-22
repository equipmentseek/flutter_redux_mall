import 'package:flutter/animation.dart';

class DoubleTween extends Tween<double> {
  DoubleTween({double begin, double end}) : super(begin: begin, end: end);

  @override
  double lerp(double t) => begin + (end - begin) * t;
}