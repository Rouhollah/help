import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:help/models/ball.dart';

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
  double screenWidth = window.physicalSize.width / window.devicePixelRatio;
  double screenHeight = window.physicalSize.height / window.devicePixelRatio;

  Ball ball = new Ball();

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _tweenOffset = Tween<Offset>(begin: Offset.zero, end: getRandomOffset());
    _animationOffset = _tweenOffset.animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    )..addListener(() {
        setState(() {
          if (_animationOffset.isCompleted) {
            if (_tweenOffset.end.dx > 100) {
              print("object");
              //  _animationController.stop();
            } else {
              setNewPosition();
            }
          }
        });
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
        child: SlideTransition(
            position: _animationOffset, child: ball.createBall()));
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
    int maxWidth = (screenWidth / ball.width).round();
    int maxHeight = (screenHeight / ball.height).round();
    print("$maxWidth,$maxHeight");
    var dx = generateRandomNumber(min: 0, max: maxWidth - 1);
    var dy = generateRandomNumber(min: 0, max: maxHeight - 1);
    print("Offset($dx,$dy)");
    return Offset(dx.toDouble(), dy.toDouble());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
