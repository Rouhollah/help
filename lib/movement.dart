import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:help/models/ball.dart';
import 'package:help/models/box.dart';
import 'package:help/models/cursor.dart';
import 'package:help/models/game_status.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

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
  int c = 0;

  @override
  void initState() {
    super.initState();
    Offset init = initialBallPosition();
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _tweenOffset = Tween<Offset>(begin: init, end: init);
    _animationOffset = _tweenOffset.animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    )..addListener(() {
        if (_animationController.status == AnimationStatus.completed) {
          collision();
        }
      });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameStatus>(context);

    if (game.firstShoot) {
      Provider.of<GameStatus>(context, listen: false).ballDirection = 90;
      var o = findDestination(game.ballDirection);
      setNewPosition(o);
    } else {
      if (game.boxes.length == 0) {
        end();
      } else {}
    }
    //});
    return UnconstrainedBox(
        child: (SlideTransition(
            position: _animationOffset, child: ball.createBall())));
  }

  /// پیدا کردن نقطه انتهایی حرکت توپ
  findDestination(degree) {
    var g = Provider.of<GameStatus>(context, listen: false);
    Offset ballPosition = g.getBallPosition();
    Offset o = Offset(ballPosition.dx, 0);
    switch (degree) {
      case 90:
        List<Box> xBoxes = sameXForBallAndBoxes();
        if (xBoxes.length > 0) {
          Provider.of<GameStatus>(context, listen: false).boxCollideWithBall =
              xBoxes.last;
          Box yBox = g.boxCollideWithBall;
          o = Offset(
              ballPosition.dx, (yBox.position.dy + yBox.height) / ball.width);
        } else {
          o = Offset(ballPosition.dx, 0);
        }

        return o;
        break;
      case 30:
        o = Offset(
            0,
            (math.sin(degreeToRadians(30)) + ballPosition.dy * ball.width) /
                ball.width);

        return o;
        break;
      default:
    }
  }

  /// یافتن موقعیت جدید
  void setNewPosition(Offset endPosition) {
    _tweenOffset.begin = _tweenOffset.end;
    _animationController.reset();
    _tweenOffset.end = endPosition;
    Provider.of<GameStatus>(context, listen: false).setBallPosition(
        Offset(endPosition.dx * ball.width, endPosition.dy * ball.width));
    _animationController.forward();
  }

  collision() {
    var g = Provider.of<GameStatus>(context, listen: false);
    Offset ballPosition = g.getBallPosition();
    Offset ballMiddlePosition = getmiddleOfBall();
    int ballDirection = g.ballDirection;
    Box box = g.boxCollideWithBall;
    switch (ballDirection) {
      case 90:
        if (ballPosition.dy == 0) {
          //TODO: برخورد با بالای صفحه
        }
        // اگر توپ به یک پنجم سمت چپ مربع برخورد کرد
        else if (ballMiddlePosition.dx >= box.position.dx / ball.width &&
            ballMiddlePosition.dx <
                (box.position.dx + (box.width / 5)) / ball.width) {
          ballDirection = 30;
          g.ballDirection = 30;
          var o = findDestination(g.ballDirection);
          setNewPosition(o);
        } else if (ballMiddlePosition.dx >=
                (box.position.dx -
                    (box.width - box.width * 4 / 5) / ball.width) &&
            ballMiddlePosition.dx <
                (box.position.dx + box.width) / ball.width) {
          ballDirection = -30;
          g.ballDirection = -30;
          var o = findDestination(g.ballDirection);
          setNewPosition(o);
        }

        break;
      default:
    }
  }

  // /// تنظیم مسیر حرکت توپ
  // void setDirection(degree) {
  //   var g = Provider.of<GameStatus>(context, listen: false);
  //   var o = findDestination(degree);
  //   setNewPosition(o);
  // }

  checkTheRoute() {
    var g = Provider.of<GameStatus>(context, listen: false);
    List<Box> xBoxes = sameXForBallAndBoxes();
    if (xBoxes.length > 0) {
      var ballPos = g.getBallPosition();
      var yBoxes = xBoxes
          .where((b) =>
              ((b.position.dy + b.height) / ball.width) >= ballPos.dy &&
              (b.position.dy / ball.width) <= ballPos.dy)
          .toList();
      if (yBoxes.length > 0) {
        Offset o = Offset(ballPos.dx,
            (yBoxes[0].position.dy + yBoxes[0].height) / ball.width);
        // //new Future.delayed(Duration(seconds: 1), () {
        // g.getBallPosition();
        // //});
        // Provider.of<GameStatus>(context, listen: false).setBallPosition(o);
        // print("Ball Width:${ball.width}");
        // print("ballPosition:$ballPos");
        // print("yBoxes:${yBoxes[0].position}");
        // print(
        //     "yBoxes DY:${(yBoxes[0].position.dy + yBoxes[0].height) / ball.width}");

        _animationController.stop();
      }
    }
  }

  updateBallPosition() {
    RenderBox renderBox = ball.key.currentContext.findRenderObject();
    Offset offset = renderBox.localToGlobal(Offset.zero);
    Provider.of<GameStatus>(context, listen: false).setBallPosition(offset);
    // print("offset:$offset");
    //var pos = Provider.of<GameStatus>(context, listen: false).getBallPosition();
    //print("listenToBallPosition:${pos}");
  }

  /// مربع و انتهای ضلع مربع است x وسط توپ بین x پیدا کردن مربع هایی که
  List<Box> sameXForBallAndBoxes() {
    var g = Provider.of<GameStatus>(context, listen: false);
    var middleOfBall = getmiddleOfBall();
    var tempBoxes = g.boxes
        .where((element) =>
            element.position.dx / ball.width <= middleOfBall.dx &&
            (element.position.dx + element.width) / ball.width >=
                middleOfBall.dx)
        .toList()
          ..sort((a, b) => a.position.dy.compareTo(b.position.dy));
    return tempBoxes;
  }

  /// مقدار دهی اولیه موقعیت توپ
  Offset initialBallPosition() {
    var bw = ball.width;
// بر اساس اندازه صفحه تقسیم بر اندازه آبجکتی است که قرار است حرکت کند SlideTransition چون مختصات
// این محاسبات جای دقیق توپ روی کرسر را درابتدا پیدا می کند
    double dx = (cursor.position.dx + cursor.width / 2 - bw / 2) / bw;
    double dy = ((cursor.position.dy - ball.height) / bw);
    // دوباره بر عرض توپ تقسیم می شوند provider در عرض توپ ضرب میشوند اما در dy و dx اینجا
    Offset offset = Offset(dx * bw, dy * bw);
    Provider.of<GameStatus>(context, listen: false).setBallPosition(offset);
    return Offset(dx, dy);
  }

  int generateRandomNumber({min = 1, max = 20}) {
    int num = min + _random.nextInt(max - min);
    return num;
  }

  end() {}

  /// تبدیل درجه به رادیانس
  num degreeToRadians(num degree) {
    return (degree * math.pi) / 180;
  }

  /// تبدیل رادیانس به درجه
  num radianseToDegree(num radianse) {
    return (radianse * 180) / math.pi;
  }

  /// یافتن نقطه محل برخورد توپ
  Offset getmiddleOfBall() {
    var g = Provider.of<GameStatus>(context, listen: false);
    var ballPos = g.getBallPosition();
    var middleOfBall =
        Offset(ballPos.dx + (ball.width / 2) / ball.width, ballPos.dy);
    return middleOfBall;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

/// موقعیت توپ در هر لحظه
// ballPositionAnyTime(game) {
//   return game.ballPostion;
// }

// Offset getRandomOffset() {
//   int maxWidth = (screenWidth / ball.width).round();
//   int maxHeight = (screenHeight / ball.height).round();
//   print("$maxWidth,$maxHeight");
//   var dx = generateRandomNumber(min: 0, max: maxWidth - 1);
//   var dy = generateRandomNumber(min: 0, max: maxHeight - 1);
//   print("Offset($dx,$dy)");
//   return Offset(dx.toDouble(), dy.toDouble());
// }
