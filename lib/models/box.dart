import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:help/models/thing.dart';
import 'package:help/models/values/device.dart';

class Box extends Thing {
  double get width => Screen.screenWidth / 10;
  double get height => Screen.screenWidth / 10;
  //Color color;
  final key = new GlobalKey();

  Box({String type = 'natural', double x, double y}) {
    position = Offset(x, y);
    switch (type) {
      case 'fire':
        color = Colors.yellow;
        break;
      case 'stone':
        color = Colors.blueGrey;
        break;
      case 'bomb':
        color = Colors.black;
        break;
      case 'earthquake':
        color = Colors.red;
        break;
      default:
        color = Colors.green;
    }
    create();
  }

  // factory Box.formJson(Map<String, dynamic> json) {
  //   List<Box> lst = new List<Box>();
  //   for (var box in json['boxes']) {
  //     var type = box['type'];
  //     var x = box['x'];
  //     var y = box['y'];
  //     Box b = new Box(type: type, x: x, y: y);
  //     lst.add(b);
  //   }
  //   return lst;
  // }

  @override
  Column create() {
    return Column(
      key: key,
      children: [Container(width: width, height: height, color: color)],
    );
  }
  // double _width;
  // void setWidth(width) => _width = width;
  // double getWidth() => _width;
  // Column _column;
  // Box();
  // Box.body(GlobalKey key, double width, double height, Color color) {
  //   this.key = key;
  //   this.width = width;
  //   this.height = height;
  //   this.color = color;
  //   _column = Column(
  //     key: key,
  //     children: [
  //       Container(
  //         width: width,
  //         height: height,
  //         color: color,
  //       )
  //     ],
  //   );
  // }
}
