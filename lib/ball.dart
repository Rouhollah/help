import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:help/thing.dart';

class Ball extends Thing {
  @override
  double get width => 25.0;
  double get height => 25.0;
  Color get color => Colors.green[300];
  double leftPosition;
  double topPosition;

  Container createBall() {
    return Container(
      color: color,
      width: width,
      height: height,
    );
  }

  Container heavyBall() {
    return Container(
      color: Colors.red,
      width: width * 1.5,
      height: height * 1.5,
    );
  }
}
