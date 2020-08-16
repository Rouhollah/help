import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:help/ball.dart';
import 'package:help/cursor.dart';

class TrackFinger extends StatefulWidget {
  @override
  _TrackFingerState createState() => _TrackFingerState();
}

class _TrackFingerState extends State<TrackFinger> {
  //window.physicalSize.width = 1280
  //window.devicePixelRatio = 2
  // cursor() / 2 =>  50
  double posx = (window.physicalSize.width / window.devicePixelRatio) - 50;
  double posy = 25.0;
  Cursor cursor = new Cursor();
  Ball ball = new Ball();
  @override
  Widget build(BuildContext context) {
    print('${window.physicalSize.width}');
    print('${window.physicalSize.width / window.devicePixelRatio}');
    print('${window.physicalSize.width / window.devicePixelRatio / 2}');
    print('${window.physicalSize.height}');
    print('${window.devicePixelRatio}');
    return _body();
  }

  Widget _body() {
    return new GestureDetector(
      onTapDown: (TapDownDetails details) => onTapDown(context, details),
      child: new Stack(children: <Widget>[
        new Container(
          color: Colors.purple,
        ),
        new Positioned(
          child: createCursor(),
          left: posx,
          top: 30.0,
        ),
        createBall(),
      ]),
    );
  }

  void onTapDown(BuildContext context, TapDownDetails details) {
    print('x Global:${details.globalPosition.dx}');
    print('y Global:${details.globalPosition.dy}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    print('x Local:${localOffset.dx}');
    print('y Local:${localOffset.dy}');
    setState(() {
      double rEdge = calculateSpaceToEdges();
      posx = localOffset.dx >= rEdge ? rEdge : localOffset.dx;
      //posy = MediaQuery.of(context).size.height - 100;
      print('posx:$posx');
      print('posy:$posy');
    });
  }

  Container createCursor() {
    return Container(
      color: cursor.color,
      height: cursor.height,
      width: cursor.width,
    );
  }

  /// توپ
  Positioned createBall() {
    Cursor cursor = new Cursor();
    Ball ball = new Ball();
    return Positioned(
      top: ball.height - cursor.height,
      left: posx + cursor.width / 2 - ball.width / 2,
      child: Container(
        width: ball.width,
        height: ball.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.green[400],
        ),
      ),
    );
  }

  calculateSpaceToEdges() {
    double rightEdge = MediaQuery.of(context).size.width - 100.toDouble();
    return rightEdge;
  }

  double initXPosition() {
    return MediaQuery.of(context).size.width / 2;
  }
}
