import 'package:flutter/material.dart';

class Thing {
  Offset position;
  double width;
  double height;
  GlobalKey key;
  Color color;
  String type;

  // createThing(type) {
  //   key = new GlobalKey();
  //   switch (type) {
  //     case 'ball':
  //       return Container(
  //         key: this.key,
  //         color: this.color,
  //         width: this.width,
  //         height: this.height,
  //       );
  //       break;
  //     case 'cursor':
  //       break;
  //     default:
  //   }
  // }
}
