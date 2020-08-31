import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:help/thing.dart';

class Ball extends Thing {
  @override
  double get width => 25.0;
  double get height => 25.0;
  Color get color => Colors.green[400];
  double leftPosition;
  double topPosition;
  GlobalKey key = new GlobalKey();
  Container createBall() {
    return Container(
      key: key,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
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
