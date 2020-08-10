import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TrackFinger extends StatefulWidget {
  @override
  _TrackFingerState createState() => _TrackFingerState();
}

class _TrackFingerState extends State<TrackFinger> {
  //window.physicalSize.width = 1280
  //window.devicePixelRatio = 2
  // cursor() / 2 =>  50
  double posx = (window.physicalSize.width / window.devicePixelRatio) / 2 - 50;
  double posy = 5.0;

  @override
  Widget build(BuildContext context) {
    print('${window.physicalSize.height / window.devicePixelRatio}');
    print('${window.physicalSize.height}');
    print('${window.devicePixelRatio}');
    return _body();
  }

  Widget _body() {
    return new GestureDetector(
      onTapDown: (TapDownDetails details) => onTapDown(context, details),
      child: new Stack(children: <Widget>[
        new Container(
          color: Colors.white10,
        ),
        new Positioned(
          child: cursor(),
          left: posx,
          top: posy,
        ),
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

  Container cursor() {
    return Container(
      color: Colors.blue[300],
      height: 20,
      width: 100,
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
