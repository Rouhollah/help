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

  double generateRandomNumber({min = 1, max = 20}) {
    var num = min + _random.nextInt(max - min).toDouble();

    return num;
  }

  Offset getRandomOffset() {
    var w =
        (window.physicalSize.width / window.devicePixelRatio) / 2.toDouble();
    var h =
        (window.physicalSize.height / window.devicePixelRatio) / 2.toDouble();
    var dx = generateRandomNumber(min: 0, max: w);
    var dy = generateRandomNumber(min: 0, max: h);
    // var dy = 0.0;
    print("Offset($dx,$dy");
    return Offset(dx, dy);
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
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
        setState(() {});
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
    return Scaffold(
      appBar: AppBar(
        title: Text('movement page'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.yellow, width: 1.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //  Center(
            // child:
            SlideTransition(
                position: _animationOffset, child: ball.createBall()),
            //),
            RaisedButton(
              child: Text('SPIN'),
              onPressed: setNewPosition,
            )
          ],
        ),
      ),
    );
    // return Container(
    //     color: Colors.white,
    //     child: Column(
    //       children: <Widget>[
    //         Center(
    //             //   child: Transform.rotate(
    //             // angle: _animation.value,
    //             child: SlideTransition(
    //           position: _animationOffset,
    //           child: Icon(
    //             Icons.arrow_upward,
    //             size: 250.0,
    //           ),
    //         )),
    //         Expanded(
    //           child: Container(),
    //         ),
    //         RaisedButton(
    //           child: Text('SPIN'),
    //           onPressed: setNewPosition,
    //         )
    //       ],
    //     ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
