import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:help/models/cursor.dart';
import 'package:help/models/game_status.dart';
import 'package:help/models/values/device.dart';
import 'package:provider/provider.dart';

class TrackFinger extends StatefulWidget {
  @override
  _TrackFingerState createState() => _TrackFingerState();
}

class _TrackFingerState extends State<TrackFinger> {
  bool firstShoot = true;
  Cursor cursor = new Cursor();
  double posy;
  double posx;
  @override
  void initState() {
    super.initState();

    //window.physicalSize.height=> height of device
    //window.physicalSize.height / window.devicePixelRatio => height of screen

    //initial positon of cursor
    posy = Screen.screenHeight - (5 * cursor.height);
    posx = Screen.screenWidth / 2 - cursor.width / 2;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) => onTapDown(context, details),
      child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        Container(
          color: Colors.yellow[200],
        ),
        AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            top: posy,
            left: posx,
            child: cursor.createCursor()),
      ]),
    );
  }

  void onTapDown(BuildContext context, TapDownDetails details) {
    if (firstShoot) {
      Provider.of<GameStatus>(context, listen: false).gameStart(firstShoot);
      firstShoot = false;
    }
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      double rEdge = calculateSpaceToRightEdges();
      posx = localOffset.dx >= rEdge ? rEdge : localOffset.dx;
    });
  }

  calculateSpaceToRightEdges() {
    double rightEdge = MediaQuery.of(context).size.width - 100.toDouble();
    return rightEdge;
  }
}
