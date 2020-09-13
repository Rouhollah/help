import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:help/boxes.dart';
import 'package:help/models/ball.dart';
import 'package:help/models/cursor.dart';
import 'package:help/models/game_status.dart';
import 'package:help/movement.dart';
import 'package:help/trackFinger.dart';
import 'package:provider/provider.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> with TickerProviderStateMixin {
  // double screenWidth;
  // double screenHeigth;
  Random random = new Random();
  Cursor cursor = new Cursor();

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
    Offset bp = initialBallPostition();
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(
    //       create: (context) =>
    //           GameStatus(false, bp, cursor.leftPosition, cursor.topPosition),
    //     )
    //   ],
    //   child: SafeArea(
    //     top: true,
    //     bottom: true,
    //     child: Stack(children: [
    //       TrackFinger(),
    //       Boxes(),
    //       Movement(),
    //     ]),
    //   ),
    // );
    return ChangeNotifierProvider<GameStatus>(
      create: (context) => GameStatus(),
      child: SafeArea(
        top: true,
        bottom: true,
        child: Stack(children: [
          TrackFinger(),
          Boxes(),
          Movement(),
        ]),
      ),
    );
    // return SafeArea(
    //   top: true,
    //   bottom: true,
    //   child: Stack(children: [
    //     TrackFinger(),
    //     Boxes(),
    //     Movement(),
    //   ]),
    // );
  }

  Offset initialBallPostition() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Ball ball = new Ball();
    double dx = screenWidth / ball.width;
    double dy = screenHeight / ball.height;
    Offset ballPosition = Offset(dx, dy);
    return ballPosition;
  }
}
