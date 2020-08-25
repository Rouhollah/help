import 'dart:ui';

import 'package:flutter/cupertino.dart';

abstract class Thing {
  Offset position;
  double width;
  double height;
  Key key;
  Color color;
}
