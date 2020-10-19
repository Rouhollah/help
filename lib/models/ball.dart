import 'package:flutter/material.dart';
import 'package:help/models/thing.dart';
import 'package:help/models/values/device.dart';

class Ball extends Thing {
  @override
  double get width => Screen.screenWidth / 20;
  double get height => Screen.screenWidth / 20;
  Color get color => Colors.green[400];
  final key = GlobalKey();

  /// ساخت توپ
  Container createBall() {
    return Container(
      key: key,
      width: width.toDouble(),
      height: height.toDouble(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
    );
  }

  /// توپ سنگین
  Container heavyBall() {
    return Container(
      key: key,
      color: Colors.red,
      width: width * 1.5,
      height: height * 1.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
    );
  }
}
