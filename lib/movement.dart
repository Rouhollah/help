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
  GameStatus game = new GameStatus();
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
    //final game = Provider.of<GameStatus>(context);
    for (var item in game.getAllBox()) {
      RenderBox renderbox = item.key.currentContext.findRenderObject();
      final Offset localOffset = renderbox.localToGlobal(Offset.zero);
      item.position = localOffset;
    }
    setState(() {
      if (game.firstShoot) {
        setDirection('up');
      } else {
        // TO DO: آیا مربعی باقی مانده است؟
        var boxes = game.getAllBox();
        if (boxes.length == 0) {
          end();
        } else {
          // TO DO: موقعیت توپ را هر لحظه اعلام کن
          Offset ballPositionNow = ballPositionAnyTime(game);
          // TO DO: آیا توپ از کرسر عبور کرده است؟
          if (ballPositionNow.dy > cursor.topPosition) {
            end();
          } else {
            // TO DO: موقعیت توپ را هر لحظه اعلام کن

          }
        }
        // TO DO: آیا با مربعی برخورد کرد ؟
        // TO DO: اگر برخورد کرده مربع را حذف کن و از آرایه هم حذف کن ؟
        // TO DO: آیا با کناره ها برخورد کرد ؟
        // TO DO: جهت را مشخص کن و به حرکت ادامه بده
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

  /// یافتن موقعیت جدید
  void setNewPosition(Offset endPosition) {
    _tweenOffset.begin = _tweenOffset.end;
    _animationController.reset();
    _tweenOffset.end = endPosition;
    checkTheRoute();
    _animationController.forward();
  }

  /// تنظیم مسیر حرکت توپ
  void setDirection(direction) {
    switch (direction) {
      case 'up':
        // حرکت مستقیم به بالا
        // محاسبه برخورد با باکس ها و تعیین مسیر برگشت
        Offset endPos = Offset(ball.position.dy, 0);
        setNewPosition(endPos);
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

  checkTheRoute() {
    var boxes = game.getAllBox();
    var tempBoxes = boxes
        .where((element) => element.position.dx == ball.position.dx)
        .toList();
    setState(() {
      for (var b in tempBoxes) {
        print(b.position);
        print(ball.position);
        if (game.ballPostion.dy == b.position.dy) {
          print('crash');
        }
      }
      crash();
    });
  }

  crash() {}

  /// مقدار دهی اولیه موقعیت توپ
  Offset initialBallPosition() {
    var bw = ball.width;
// بر اساس اندازه صفحه تقسیم بر اندازه آبجکتی است که قرار است حرکت کند SlideTransition چون مختصات
// این محاسبات جای دقیق توپ روی کرسر را درابتدا پیدا می کند
    double dx = (cursor.position.dx + cursor.width / 2 - bw / 2) / bw;
    double dy = ((cursor.position.dy - 2 * cursor.height) / bw);
    Offset offset = Offset(dx, dy);
    Provider.of<GameStatus>(context, listen: false).setBallPosition(offset);
    return offset;
  }

  int generateRandomNumber({min = 1, max = 20}) {
    int num = min + _random.nextInt(max - min);
    return num;
  }

  /// موقعیت توپ در هر لحظه
  ballPositionAnyTime(game) {
    return game.ballPostion;
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
  end() {}

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
