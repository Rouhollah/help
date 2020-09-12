import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:help/boxes.dart';
import 'package:help/movement.dart';
import 'package:help/services/inherited_provider.dart';
import 'package:help/trackFinger.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> with TickerProviderStateMixin {
  // double screenWidth;
  // double screenHeigth;
  Random random = new Random();

  @override
  void initState() {
    super.initState();
//دسترسی به  content
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Schedule code execution once after the frame has rendered
      // print(MediaQuery.of(context).size.toString());
    });
    //or
    // new Future.delayed(Duration.zero, () {
    //       // Schedule a zero-delay future to be executed
    //       print(MediaQuery.of(context).size.toString());
    //   });
  }

  @override
  Widget build(BuildContext context) {
    // screenWidth = MediaQuery.of(context).size.width;
    // screenHeigth = MediaQuery.of(context).size.height;

    return SafeArea(
      top: true,
      bottom: true,
      child: Stack(children: [
        TrackFinger(),
        Boxes(),
        Movement(),
      ]),
    );
  }
}
