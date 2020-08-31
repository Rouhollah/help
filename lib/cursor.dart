import 'package:flutter/material.dart';

class Cursor {
  double width = 100.0;
  double height = 20.0;
  Color color = Colors.blue[300];
  Offset position;
  double leftPosition;
  double topPosition;
  GlobalKey key = new GlobalKey();
  Container createCursor() {
    return Container(
      key: key,
      width: width,
      height: height,
      color: color,
    );
  }
}
