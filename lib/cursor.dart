import 'package:flutter/material.dart';
import 'package:help/thing.dart';

class Cursor extends Thing {
  double get width => 100.0;
  double get height => 20.0;
  Color get color => Colors.blue[300];

  Container createCursou() {
    return Container(
      color: color,
      width: width,
      height: height,
    );
  }

  Container biggerCursor() {
    return Container(
      color: Colors.blue[300],
      width: width + 20,
      height: height,
    );
  }
}
