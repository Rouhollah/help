import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:help/boxes.dart';
import 'package:help/models/cursor.dart';
import 'package:help/models/game_status.dart';
import 'package:help/movement.dart';
import 'package:help/trackFinger.dart';
import 'package:provider/provider.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Random random = new Random();
  Cursor cursor = new Cursor();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    // content دسترسی به
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
    return ChangeNotifierProvider<GameStatus>(
      create: (context) => GameStatus(),
      child: Stack(children: [
        TrackFinger(),
        Boxes(),
        Movement(),
      ]),
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

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}
