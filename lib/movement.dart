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
  Animation<double> _animation;
  Animation<Offset> _animationOffset;
  Tween<double> _tween;
  Tween<Offset> _tweenOffset;
  AnimationController _animationController;
  //math.Random _random = math.Random();
  Random _random = new Random();
  int position = 0;

  Ball ball = new Ball();

  // double getRandomAngle() {
  //   return math.pi * 2 / 25 * _random.nextInt(25);
  // }

  int generateRandomNumber({min = 1, max = 20}) {
    int num = min + _random.nextInt(max - min);
    return num;
  }

  Offset getRandomOffset() {
    int w = ((window.physicalSize.width / window.devicePixelRatio) / 2).round();
    int h =
        ((window.physicalSize.height / window.devicePixelRatio) / 2).round();
    var dx = generateRandomNumber(min: 0, max: w);
    var dy = generateRandomNumber(min: 0, max: h);
    // var dy = 0.0;
    print("Offset($dx,$dy");
    return Offset(dx.toDouble(), dy.toDouble());
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    // _tween = Tween(begin: 0.0, end: getRandomAngle());
    // _animation = _tween.animate(_animationController)
    //   ..addListener(() {
    //     setState(() {
    //       print("animationvalue${_animation.value}");
    //     });
    //   });
    _tweenOffset =
        Tween<Offset>(begin: Offset(0.0, 0.0), end: getRandomOffset());
    _animationOffset = _tweenOffset.animate(_animationController)
      ..addListener(() {
        setState(() {
          if (_animationOffset.isCompleted) {
            setNewPosition();
          } else {}
        });
      });
  }

  void setNewPosition() {
    // _tween.begin = _tween.end;
    _tweenOffset.begin = _tweenOffset.end;
    _animationController.reset();
    // _tween.end = getRandomAngle();
    _tweenOffset.end = getRandomOffset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: _animationOffset, child: ball.createBall());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
