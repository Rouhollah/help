import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:help/ball.dart';
import 'package:help/cursor.dart';

class TrackFinger extends StatefulWidget {
  @override
  _TrackFingerState createState() => _TrackFingerState();
}

class _TrackFingerState extends State<TrackFinger>
    with SingleTickerProviderStateMixin {
  bool firstShoot = true;
  //window.physicalSize.width = 1280
  //window.devicePixelRatio = 2
  // cursor() / 2 =>  50
  double posx = (window.physicalSize.width / window.devicePixelRatio) / 2 - 50;
  //double posx = window.physicalSize.width / window.devicePixelRatio - 100;
  double posy = 25.0;
  Cursor cursor = new Cursor();
  Ball ball = new Ball();

  AnimationController controller;
  Animation animation;
  Offset _start = Offset(0, 0);
  Offset _end = Offset(0.0, -0.4);

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    // #docregion addListener
    animation = Tween<Offset>(begin: _start, end: _end).animate(controller)
      ..addListener(() {
        // #enddocregion addListener
        setState(() {
          // The state that has changed here is the animation object’s value.
          // print(animation.value);
        });
        // #docregion addListener
      });
    // #enddocregion addListener
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTapDown: (TapDownDetails details) => onTapDown(context, details),
      child: new Stack(alignment: Alignment.bottomCenter, children: <Widget>[
        new Container(
          color: Colors.yellow[200],
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
        ),
        // new Positioned(
        //   child: cursor.createCursor(), //createCursor(),
        //   left: posx,
        //   bottom: 20,
        //   // top: cursor.height * 3,
        // ),
        AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            // top: 100,
            left: posx,
            child: cursor.createCursor()),
      ]),
    );
  }

  void onTapDown(BuildContext context, TapDownDetails details) {
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
