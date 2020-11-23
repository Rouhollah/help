import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:help/models/ball.dart';
import 'package:help/models/box.dart';
import 'package:help/models/cursor.dart';
import 'package:help/models/game_status.dart';
import 'package:help/services/mathematics_service.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'models/values/device.dart';

class Movement extends StatefulWidget {
  @override
  _MovementState createState() => _MovementState();
}

class _MovementState extends State<Movement> with SingleTickerProviderStateMixin {
  Animation<Offset> _animationOffset;
  Tween<Offset> _tweenOffset;
  AnimationController _animationController;
  Random _random = new Random();
  Cursor cursor = new Cursor();
  Ball ball = new Ball();
  String direction;
  int c = 0;
  MathematicsService ms = MathematicsService();

  @override
  void initState() {
    super.initState();
    Offset init = initialBallPosition();
    _animationController = AnimationController(duration: Duration(seconds: 1), vsync: this);
    _tweenOffset = Tween<Offset>(begin: init, end: init);
    _animationOffset = _tweenOffset.animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    )..addListener(() {
        if (_animationController.status == AnimationStatus.completed) {
          print(c++);
          collision();
        }
      });

    // در نقطه شروع بایستد
    _animationController.isDismissed;
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameStatus>(context, listen: false);

    print("movement");
    return Selector<GameStatus, bool>(
        selector: (ctx, game) => game.firstShoot,
        builder: (context, startGame, child) {
          if (startGame) {
            game.ballDirection = 90;
            routing(game.ballDirection);
            // List<Offset> offsetList = new List<Offset>();
            // // Offset o = findDestination(game.ballDirection);
            // // setNewPosition(o);
            // List<Box> lstBox = findBoxesInRouteBall(90);
            // game.boxCollideWithBall = lstBox.length > 0 ? lstBox.last : null;
            // offsetList = calculateCoordinates(game.boxCollideWithBall, 90);
            // setNewPosition(offsetList[1]);
          }
          return UnconstrainedBox(child: (SlideTransition(position: _animationOffset, child: ball.createBall())));
        });
  }

  routing(int degree) {
    final game = Provider.of<GameStatus>(context, listen: false);
    List<Offset> offsetList = new List<Offset>();
    List<Box> lstBox = findBoxesInRouteBall(degree);
    if (degree < 180)
      game.boxCollideWithBall = lstBox.length > 0 ? lstBox.last : null;
    else
      game.boxCollideWithBall = lstBox.length > 0 ? lstBox.first : null;

    offsetList = calculateCoordinates(game.boxCollideWithBall, degree);
    setNewPosition(offsetList[1]);
  }

  /// پیدا کردن نقطه انتهایی حرکت توپ
  Offset findDestination(int degree) {
    var g = Provider.of<GameStatus>(context, listen: false);
    Offset ballPosition = g.getBallPosition();
    Offset o = Offset(ballPosition.dx, 0);
    List<Box> temp;

    switch (degree) {
      case 30:
        break;
      case 45:
        break;
      case 60:
        break;
      case 90:
        List<Box> lstBox = findBoxesInRouteBall(degree);
        if (lstBox.length > 0) {
          Provider.of<GameStatus>(context, listen: false).boxCollideWithBall = lstBox.last;
          Box yBox = g.boxCollideWithBall;
          o = Offset(ballPosition.dx, (yBox.position.dy + yBox.height) / ball.width);
        } else {
          o = Offset(ballPosition.dx, 0);
        }
        return o;
        break;
      case 120:
        break;
      case 135:
        break;
      case 150:
        break;
      case 210:
        //o = Offset(0, math.sin(degreeToRadians(90)) + ballPosition.dy);
        o = Offset(0, 4 + ballPosition.dy);
        Offset beginning = ms.transitionPositionToScreenPosition(Offset(ballPosition.dx, ballPosition.dy));
        Offset distination = ms.transitionPositionToScreenPosition(o);
        temp = findBoxesInRouteBall(degree);
        for (var b in temp) {
          var x =
              ms.equationOfLine(null, b.position.dy, beginning.dx + topOfBall().dx, beginning.dy + bottomOfBall().dy, distination.dx, distination.dy);
          var y = ms.equationOfLine(x, null, beginning.dx + ball.width / 2, beginning.dy + ball.width / 2, distination.dx, distination.dy);
          // اگر به بالای مربع خرود
          if (x >= b.position.dx && x <= b.position.dx + b.width) {
            o = ms.screenPositionToTransitionPosition(Offset(x - leftOfBall().dx, b.position.dy - ball.width));
          }
          // اگر به سمت راست مربع خورد
          else if (y >= b.position.dy && y <= b.position.dy + b.width) {
            o = ms.screenPositionToTransitionPosition(Offset(x, y));
            g.ballDirection = 330;
          } else
            continue;
        }
        return o;
        break;
      case 225:
        break;
      case 240:
        break;
      case 270:
        break;
      case 300:
        break;
      case 315:
        break;
      case 330:
        o = Offset(Screen.screenWidth / ball.width, 4 + ballPosition.dy);
        Offset beginning = ms.transitionPositionToScreenPosition(Offset(ballPosition.dx, ballPosition.dy));
        Offset distination = ms.transitionPositionToScreenPosition(o);
        temp = findBoxesInRouteBall(degree);
        for (var b in temp) {
          var x =
              ms.equationOfLine(null, b.position.dy, beginning.dx + topOfBall().dx, beginning.dy + bottomOfBall().dy, distination.dx, distination.dy);
          var y = ms.equationOfLine(x, null, beginning.dx + topOfBall().dx, beginning.dy + bottomOfBall().dy, distination.dx, distination.dy);

          // اگر به بالای مربع خورد
          if (x >= b.position.dx && x <= b.position.dx + b.width) {
            o = ms.screenPositionToTransitionPosition(Offset(x + rightOfBall().dx, b.position.dy - ball.width));
            g.ballDirection = 30;
          }
          // اگر به سمت چپ مربع خورد
          else if (y >= b.position.dy && y <= b.position.dy + b.width) {
            o = ms.screenPositionToTransitionPosition(Offset(x, b.position.dy + rightOfBall().dy));
            g.ballDirection = 210;
          }
        }
        return o;
        break;
      default:
        return o;
    }
  }

  /// یافتن موقعیت جدید
  void setNewPosition(Offset endPosition) {
    _tweenOffset.begin = _tweenOffset.end;
    _animationController.reset();
    _tweenOffset.end = endPosition;
    Provider.of<GameStatus>(context, listen: false).setBallPosition(Offset(endPosition.dx * ball.width, endPosition.dy * ball.width));
    _animationController.forward();
  }

  collision() {
    var g = Provider.of<GameStatus>(context, listen: false);
    Offset leftBallPos = leftOfBall();
    Offset bottomBallPos = bottomOfBall();
    Offset topBallPos = topOfBall();
    Offset rightBallPos = rightOfBall();
    Offset ballPosition = g.getBallPosition();
    int degree = g.ballDirection;
    Box box = g.boxCollideWithBall;

    // Transition Position مختصات مربع بر اساس
    Offset boxTransitionPosition;

    if (box != null) {
      boxTransitionPosition = ms.screenPositionToTransitionPosition(Offset(box.position.dx, box.position.dy));
      // حرکت توپ به سمت بالا بوده است
      if (0 < degree && degree < 180) {
// برخورد با زیر مربع
        if (ballPosition.dy >= boxTransitionPosition.dy) {
          underBoxCollide(boxTransitionPosition);
//TODO: پیاده سازی متد برخورد با زیر مربع
        } else {
          //TODO: پیاده سازی متد برخورد با سمت چپ یا راست مربع مربع

        }
      }
      // حرکت توپ به سمت پایین بوده است
      else if (180 < degree && degree < 360) {
        if (ballPosition.dy <= boxTransitionPosition.dy) {
          //TODO: پیاده سازی متد برخورد با بالای مربع
        } else {
          //TODO: پیاده سازی متد برخورد با سمت چپ یا راست مربع مربع
        }
      }
    } else {
      //TODO: محاسبه جهت حرکت توپ- دراین حالت توپ با کناره ها یا بالا یا کرسر برخورد کرده و یا بازی تمام شده است
//g.ballDirection=

    }
    // switch (degree) {
    //   case 90:
    //     // برخورد با بالای صفحه
    //     if (ballPosition.dy == 0) {
    //       var lstBox = findBoxesInRouteBall(270);
    //       g.boxCollideWithBall = lstBox.length > 0 ? lstBox.first : null;
    //       var offsetList = calculateCoordinates(g.boxCollideWithBall, 270);
    //       g.ballDirection = 270;
    //       setNewPosition(offsetList[1]);
    //     }
    //     // اگر توپ به یک پنجم سمت چپ مربع برخورد کرد
    //     else if (ballMiddlePosition.dx >= box.position.dx / ball.width && ballMiddlePosition.dx < (box.position.dx + (box.width / 5)) / ball.width) {
    //       g.ballDirection = 210;
    //       g.removeBox();
    //       var o = findDestination(g.ballDirection);
    //       setNewPosition(o);
    //     }
    //     // اگر توپ به یک پنجم سمت راست مربع برخورد کرد
    //     else if (ballMiddlePosition.dx >= (box.position.dx - (box.width - box.width * 4 / 5) / ball.width) &&
    //         ballMiddlePosition.dx < (box.position.dx + box.width) / ball.width) {
    //       g.ballDirection = 330;
    //       g.removeBox();
    //       var o = findDestination(g.ballDirection);
    //       setNewPosition(o);
    //     }
    //     // برخورد با جایی غیر از گوشه های مربع
    //     else if (topOfBall().dy == (box.position.dy + box.width) / ball.width) {
    //       g.removeBox();
    //       var lstBox = findBoxesInRouteBall(270);
    //       g.boxCollideWithBall = lstBox.length > 0 ? lstBox.first : null;
    //       var offsetList = calculateCoordinates(g.boxCollideWithBall, 270);
    //       setNewPosition(offsetList[1]);
    //     }
    //     break;
    //   case 210:
    //     var lstBox = findBoxesInRouteBall(210);
    //     var offsetList = calculateCoordinates(lstBox.first, 210);
    //     setNewPosition(offsetList[1]);
    //     // var o = findDestination(g.ballDirection);
    //     // setNewPosition(o);
    //     break;
    //   case 270:
    //     //TODO: متد برخورد با کرسر
    //     var lstBox = findBoxesInRouteBall(90);
    //     g.boxCollideWithBall = lstBox.length > 0 ? lstBox.last : null;
    //     var offsetList = calculateCoordinates(lstBox.first, 90);
    //     setNewPosition(offsetList[1]);
    //     break;

    //   case 330:
    //     var o = findDestination(g.ballDirection);
    //     setNewPosition(o);
    //     break;
    //   default:
    // }
  }

  /// متد برخورد با زیر مربع
  underBoxCollide(Offset boxTransitionPosition) {
    var g = Provider.of<GameStatus>(context, listen: false);
    Offset topBallPos = topOfBall();
    double boxWidth = Box().width;

    // اگر توپ به یک پنجم سمت چپ مربع برخورد کرد
    if (topBallPos.dx >= boxTransitionPosition.dx / ball.width && topBallPos.dx < (boxTransitionPosition.dx + (boxWidth / 5)) / ball.width) {
      g.ballDirection = 210;
    }
    // اگر توپ به یک پنجم سمت راست مربع برخورد کرد
    else if (topBallPos.dx >= (boxTransitionPosition.dx - (boxWidth - boxWidth * 4 / 5) / ball.width) &&
        topBallPos.dx < (boxTransitionPosition.dx + boxWidth) / ball.width) {
      g.ballDirection = 330;
    }
    // برخورد با جایی غیر از گوشه های مربع
    else if (topOfBall().dy == (boxTransitionPosition.dy + boxWidth) / ball.width) {
      g.ballDirection = findNewDegree(g.ballDirection, "under");
    }
    g.removeBox();
    routing(g.ballDirection);
  }

  findNewDegree(int degree, String point) {
    if (point == "under") {
      switch (degree) {
        case 225:
          return 315;
          break;
        case 240:
          return 300;
          break;
        case 300:
          return 240;
          break;
        case 315:
          return 225;
          break;
        default:
          return 240;
          break;
      }
    }
  }

  /// پیدا کردن مربع هایی که در مسیر توپ هستند
  List<Box> findBoxesInRouteBall(int degree) {
    var g = Provider.of<GameStatus>(context, listen: false);
    Offset ballPosition = g.getBallPosition();

    //210
    Offset topBallPos;
    Offset rightBallPos;
    Offset leftBallPos;
    Offset bottomBallPos;
    leftBallPos = leftOfBall();
    bottomBallPos = bottomOfBall();
    topBallPos = bottomOfBall();
    rightBallPos = bottomOfBall();
    List<Box> tempBoxes = new List<Box>();
    // حرکت توپ به سمت پالا
    if (0 < degree && degree < 180 && degree != 90) {
      // مربع های سمت راست توپ
      // توپ است dx آنها بیشتر یا مساوی dx مربع هایی که
      if (degree < 90) {
        tempBoxes = g
            .getBoxes()
            .where((element) => element.position.dy / ball.width <= topBallPos.dy && ballPosition.dx <= element.position.dx / ball.width)
            .toList()
              ..sort((a, b) => a.position.dy.compareTo(b.position.dy));
      }
      // مربع های سمت چپ توپ
      // توپ است dx آنها کمتر یا مساوی dx + width مربع هایی که
      else {
        tempBoxes = g
            .getBoxes()
            .where((element) =>
                element.position.dy / ball.width <= topBallPos.dy && ballPosition.dx >= (element.position.dx + element.width) / ball.width)
            .toList()
              ..sort((a, b) => a.position.dy.compareTo(b.position.dy));
      }
    }
    // حرکت توپ به سمت پایین
    else if (180 < degree && degree < 360 && degree != 270) {
      // مربع های سمت جپ توپ
      // توپ است dx آنها کمتر یا مساوی dx + width مربع هایی که
      if (degree < 270) {
        tempBoxes = g
            .getBoxes()
            .where((element) =>
                element.position.dy / ball.width >= bottomBallPos.dy && ball.position.dx >= (element.position.dx + element.width) / ball.width)
            .toList()
              ..sort((a, b) => b.position.dy.compareTo(a.position.dy));
      }
      // مربع های سمت راست توپ
      // توپ است dx آنها بیشتر یا مساوی dx مربع هایی که
      else {
        tempBoxes = g
            .getBoxes()
            .where((element) => element.position.dy / ball.width >= bottomBallPos.dy && ball.position.dx >= element.position.dx / ball.width)
            .toList()
              ..sort((a, b) => b.position.dy.compareTo(a.position.dy));
      }
    }
    // حرکت مستقیم توپ به بالا
    else if (degree == 90) {
      tempBoxes = g
          .getBoxes()
          .where((element) =>
              element.position.dx / ball.width <= topBallPos.dx &&
              topBallPos.dx <= (element.position.dx + element.width) / ball.width &&
              topBallPos.dy <= element.position.dy / ball.width)
          .toList()
            ..sort((a, b) => a.position.dy.compareTo(b.position.dy));
    } else {
      tempBoxes = g
          .getAllBox()
          .where((element) =>
              element.position.dx / ball.width <= bottomBallPos.dx &&
              (element.position.dx + element.width) / ball.width >= bottomBallPos.dx &&
              bottomBallPos.dy >= element.position.dy / ball.width)
          .toList()
            ..sort((a, b) => b.position.dy.compareTo(a.position.dy));
    }
    return tempBoxes;
  }

  /// آفست توپ و مربعی که توپ به آن خواهد خورد را بر می گرداند
  List<Offset> calculateCoordinates(Box box, int degree) {
    var g = Provider.of<GameStatus>(context, listen: false);
    Offset ballPosition = g.getBallPosition();
    List<Offset> lstOffset = new List<Offset>();
    num x, y, x2, y2;
    num x1 = ms.transitionPositionToScreenPosition(ballPosition).dx;
    num y1 = ms.transitionPositionToScreenPosition(ballPosition).dy;
    lstOffset.add(Offset(x1, y1));
    // حرکت توپ به بالا
    if (degree < 180 && degree != 90) {
      // در این زاویه ها توپ به سمت چپ مربع می خورد
      if (degree == 30 || degree == 45 || degree == 60) {
        x2 = box != null ? box.position.dx : (Screen.screenWidth - ball.width) / ball.width;
      }
      // در این زاویه ها توپ به سمت راست مربع می خورد
      else if (degree == 120 || degree == 135 || degree == 150) {
        x2 = box != null ? box.position.dx + box.width : 0.0;
      }
      // برخورد با پایین مربع
      y2 = box.position.dy + box.width;
    }
    // حرکت توپ به پایین
    else if (degree > 180 && degree != 270) {
      // در این زاویه ها توپ به سمت راست مربع می خورد
      if (degree == 210 || degree == 225 || degree == 240) {
        x2 = box != null ? box.position.dx + box.width : 0.0;
      }
      // در این زاویه ها توپ به سمت چپ مربع می خورد
      else if (degree == 300 || degree == 315 || degree == 330) {
        x2 = box != null ? box.position.dx : (Screen.screenWidth - ball.width) / ball.width;
      }
      // برخورد با بالای مربع
      y2 = box.position.dy;
    } else if (degree == 90) {
      x2 = ballPosition.dx;
      var tempY = box != null ? box.position.dy + box.width : 0.0;
      y2 = ms.screenPositionToTransitionPosition(Offset(x2, tempY)).dy;
    } else if (degree == 270) {
      x2 = ballPosition.dx;
      y2 = ms.screenPositionToTransitionPosition(Offset(x2, Screen.screenHeight - ball.width)).dy;
    }
    lstOffset.add(Offset(x2, y2));
    return lstOffset;
  }

  ///برخورد با کرسر
  colideWithCursor() {
    var g = Provider.of<GameStatus>(context, listen: false);
    var cp = ms.screenPositionToTransitionPosition(g.getCursorPosition());
    var endOfCP = ms.screenPositionToTransitionPosition(Offset(g.getCursorPosition().dx + cursor.width, cp.dy));
    // بخش اول کرسر از سمت چپ - به اندازه یک توپ
    var firstPart = ms.screenPositionToTransitionPosition(Offset(g.getCursorPosition().dx + ball.width, cp.dy));
    var secondPart = ms.screenPositionToTransitionPosition(Offset(firstPart.dx + ball.width, cp.dy));
    var thirdPart = ms.screenPositionToTransitionPosition(Offset(secondPart.dx + ball.width, cp.dy));
    var sixth = ms.screenPositionToTransitionPosition(Offset(cp.dx + cursor.width - ball.width, cp.dy));
    var fifth = ms.screenPositionToTransitionPosition(Offset(sixth.dx - ball.width, cp.dy));
    var forth = ms.screenPositionToTransitionPosition(Offset(fifth.dx - ball.width, cp.dy));
    Offset o;
    // اگر توپ به کرسر برخورد کرد
    if ((bottomOfBall().dx >= cp.dx && bottomOfBall().dx <= endOfCP.dx) && bottomOfBall().dy == cp.dy) {
      // برخورد با یک هفتم ابتدایی کرسر -30 درجه
      if (bottomOfBall().dx >= cp.dx && bottomOfBall().dx <= firstPart.dx) {
        o = Offset(0, 4 + cp.dy / ball.width);
        setNewPosition(o);
      }
      // برخورد با یک هفتم دوم -45 درجه
      else if (bottomOfBall().dx > firstPart.dx && bottomOfBall().dx <= secondPart.dx) {
        o = Offset(0, 6 + cp.dy / ball.width);
      }
      // برخورد با یک هفتم سوم -60 درچه
      else if (bottomOfBall().dx > secondPart.dx && bottomOfBall().dx <= thirdPart.dx) {
        o = Offset(0, 8 + cp.dy / ball.width);
      }
      // برخورد با یک هفتم بعد از وسط = 60 درجه
      else if (bottomOfBall().dx > forth.dx && bottomOfBall().dx <= fifth.dx) {
        o = Offset(Screen.screenWidth / ball.width, 8 + cp.dy / ball.width);
      }
      // برخورد با یک هفتم دوم بعد از وسط - 45 درچه
      else if (bottomOfBall().dx > fifth.dx && bottomOfBall().dx <= sixth.dx) {
        o = Offset(Screen.screenWidth / ball.width, 6 + cp.dy / ball.width);
      }
      // برخورد با یک هفتم آخر - 30 درچه
      else if (bottomOfBall().dx > sixth.dx && bottomOfBall().dx <= cp.dx + cursor.width) {
        o = Offset(Screen.screenWidth / ball.width, 4 + cp.dy / ball.width);
      }
      // برخورد با وسط - 90 درچه
      else {
        g.ballDirection = 90;
        findBoxesInRouteBall(90);
      }
    }
    // عبور از کرسر - باخت
    else if (bottomOfBall().dy > cp.dy) {
      gameOver();
    }
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

  gameOver() {}

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
    var middleOfBall = Offset(ballPos.dx + (ball.width / 2) / ball.width, ballPos.dy);
    return middleOfBall;
  }

  Offset leftOfBall() {
    var g = Provider.of<GameStatus>(context, listen: false);
    var ballPos = g.getBallPosition();
    var left = Offset(ballPos.dx / ball.width, ballPos.dy + (ball.width / 2) / ball.width);
    return left;
  }

  Offset rightOfBall() {
    var g = Provider.of<GameStatus>(context, listen: false);
    var ballPos = g.getBallPosition();
    var right = Offset((ballPos.dx + ball.width) / ball.width, ballPos.dy + (ball.width / 2) / ball.width);
    return right;
  }

  /// نقطه بالایی توپ
  Offset topOfBall() {
    var g = Provider.of<GameStatus>(context, listen: false);
    var ballPos = g.getBallPosition();
    var top = Offset(ballPos.dx + (ball.width / 2) / ball.width, ballPos.dy);
    return top;
  }

  Offset bottomOfBall() {
    var g = Provider.of<GameStatus>(context, listen: false);
    var ballPos = g.getBallPosition();
    var bottom = Offset(ballPos.dx + (ball.width / 2) / ball.width, (ballPos.dy + ball.width) / ball.width);
    return bottom;
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
