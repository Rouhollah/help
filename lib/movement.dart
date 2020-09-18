import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:help/models/ball.dart';
import 'package:help/models/cursor.dart';
import 'package:help/models/game_status.dart';
import 'package:help/models/values/device.dart';
import 'package:provider/provider.dart';

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
  int maxWidthForTransition;
  int maxHeightForTransition;
  Ball ball = new Ball();
  String direction;

  @override
  void initState() {
    super.initState();
    Offset init = initialBallPosition();

    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _tweenOffset = Tween<Offset>(begin: init, end: init);
    _animationOffset = _tweenOffset.animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
    // ..addListener(() {
    //     setState(() {
    //       if (_animationOffset.isCompleted) {

    //       }
    //     });
    //   });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameStatus>(context);
    setState(() {
      if (game.firstShoot) {
        setNewPosition('up');
      }
    });
    return UnconstrainedBox(
        child: (SlideTransition(
            position: _animationOffset, child: ball.createBall())));
//      return ball.createBall();

    // Consumer<GameStatus>(builder: (context, game, child) {
    //   if (game.started) {
    //     return UnconstrainedBox(
    //         child: (SlideTransition(
    //             position: _animationOffset, child: ball.createBall())));
    //   } else {
    //     return ball.createBall();
    //   }
    // });
    // return ball.createBall();
  }

  void setNewPosition(direction) {
    _tweenOffset.begin = _tweenOffset.end;
    _animationController.reset();
    _tweenOffset.end = findDistination(direction);

    _animationController.forward();
  }

  Offset findDistination(direction) {
    switch (direction) {
      case 'up':
        // حرکت مستقیم به بالا
        // محاسبه برخورد با باکس ها و تعیین مسیر برگشت
        return Offset(6.5, 0);
        break;
      case 'upRight':
        break;
      case 'upLeft':
        break;
      case 'down':
        break;
      case 'downRight':
        break;
      case 'downLeft':
        break;
    }
  }

  Offset initialBallPosition() {
    var c = new Cursor();
    maxWidthForTransition = (Screen.screenWidth / ball.width).round();
    maxHeightForTransition = (Screen.screenHeight / ball.width).round();
    double dx = (maxWidthForTransition / 2).toDouble();
    double dy = maxHeightForTransition -
        (c.position.dy / ( Screen.screenHeight / ball.width)) / 40 -
        ball.width.toDouble();
    print(" dx ball:$dx");
    print(" dy ball:$dy");
    return Offset(dx, dy);
  }

  int generateRandomNumber({min = 1, max = 20}) {
    int num = min + _random.nextInt(max - min);
    return num;
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
