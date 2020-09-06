import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'ball.dart';

class Movement extends StatefulWidget {
  @override
  _MovementState createState() => _MovementState();
}

class _MovementState extends State<Movement>
    with SingleTickerProviderStateMixin {
  Animation<Offset> _animationOffset;
  Tween<Offset> _tweenOffset;
  AnimationController _animationController;
  Random _random = new Random();

  Ball ball = new Ball();

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    // Offset(20.6, 36)
    _tweenOffset = Tween<Offset>(begin: Offset.zero, end: Offset(10, 10));
    _animationOffset = _tweenOffset.animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
    //(_animationController)
    // ..addListener(() {
    //   setState(() {
    //     if (_animationOffset.isCompleted) {
    //       if (_tweenOffset.end.dx > 100) {
    //         print("object");
    //         //  _animationController.stop();
    //       } else {
    //         //setNewPosition();
    //       }
    //     }
    //   });
    // });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   padding: EdgeInsets.only(bottom: ball.height),
    //   alignment: Alignment.bottomCenter,
    //   //height: MediaQuery.of(context).size.height,

    //   color: Colors.white,
    //   child:
    //       SlideTransition(position: _animationOffset, child: ball.createBall()),
    // );
    return UnconstrainedBox(
        child: SlideTransition(
            position: _animationOffset, child: ball.createBall()));
    // return SlideTransition(
    //     position: _animationOffset, child: ball.createBall());
  }

  int generateRandomNumber({min = 1, max = 20}) {
    int num = min + _random.nextInt(max - min);
    return num;
  }

  void setNewPosition() {
    _tweenOffset.begin = _tweenOffset.end;
    _animationController.reset();
    _tweenOffset.end = getRandomOffset();
    _animationController.forward();
  }

  Offset getRandomOffset() {
    int w = (((window.physicalSize.width / window.devicePixelRatio) / 2) / 2)
        .round();
    int h = (((window.physicalSize.height / window.devicePixelRatio) / 2) / 2)
        .round();
    var dx = generateRandomNumber(min: 0, max: 25);
    var dy = generateRandomNumber(min: 0, max: 37);
    // var dy = 0.0;
    print("Offset($dx,$dy)");
    return Offset(dx.toDouble(), dy.toDouble());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
