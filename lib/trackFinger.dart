import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:help/models/cursor.dart';
import 'package:help/models/game_status.dart';
import 'package:provider/provider.dart';

class TrackFinger extends StatefulWidget with ChangeNotifier {
  @override
  _TrackFingerState createState() => _TrackFingerState();
}

class _TrackFingerState extends State<TrackFinger> {
  bool firstShoot = true;
  //window.physicalSize.width = 1280
  //window.devicePixelRatio = 2
  // cursor() / 2 =>  50
  //double posy = (window.physicalSize.height) / 2 - 100;
  double posy;
  // double posx = (window.physicalSize.width / window.devicePixelRatio) / 2 - 50;
  double posx;
  Cursor cursor = new Cursor();

  @override
  Widget build(BuildContext context) {
    posy = MediaQuery.of(context).size.height - 100;
    posx = MediaQuery.of(context).size.width / 2 - 50;
    cursor.leftPosition = posx;
    cursor.topPosition = posy;
    return new GestureDetector(
      onTapDown: (TapDownDetails details) => onTapDown(context, details),
      child: new Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        new Container(
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
    Provider.of<GameStatus>(context, listen: false).colide();
    print('tabbed');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      double rEdge = calculateSpaceToEdges();
      posx = localOffset.dx >= rEdge ? rEdge : localOffset.dx;
    });
  }

  calculateSpaceToEdges() {
    double rightEdge = MediaQuery.of(context).size.width - 100.toDouble();
    return rightEdge;
  }
}
