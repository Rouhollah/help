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

  Cursor cursor = new Cursor();
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
    _tweenOffset.end = findDirection(direction);
    checkTheRoute();
    _animationController.forward();
  }

  Offset findDirection(direction) {
    switch (direction) {
      case 'up':
        // حرکت مستقیم به بالا
        // محاسبه برخورد با باکس ها و تعیین مسیر برگشت
        return Offset(ball.leftPosition, 0);
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

  checkTheRoute() {}

  Offset initialBallPosition() {
    var bw = ball.width;

    // چون مختصات برای
    // slideTransiotn
    // بر اساس اندازه صفحه تقسیم بر اندازه آبجکتی است که قرار است حرکت کند
    //این محاسبات جای دقیق توپ روی کرسر را درابتدا پیدا می کند
    double dx = (cursor.position.dx + cursor.width / 2 - bw / 2) / bw;
    ball.leftPosition = dx;
    double dy = ((cursor.position.dy - 2 * cursor.height) / bw);
    ball.topPosition = dy;
    return Offset(dx, dy);
  }

  int generateRandomNumber({min = 1, max = 20}) {
    int num = min + _random.nextInt(max - min);
    return num;
  }

  // Offset getRandomOffset() {
  //   int maxWidth = (screenWidth / ball.width).round();
  //   int maxHeight = (screenHeight / ball.height).round();
  //   print("$maxWidth,$maxHeight");
  //   var dx = generateRandomNumber(min: 0, max: maxWidth - 1);
  //   var dy = generateRandomNumber(min: 0, max: maxHeight - 1);
  //   print("Offset($dx,$dy)");
  //   return Offset(dx.toDouble(), dy.toDouble());
  // }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
