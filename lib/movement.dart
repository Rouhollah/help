import 'dart:math' as math;

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
  math.Random _random = math.Random();
  int position = 0;

  Ball ball = new Ball();

  double getRandomAngle() {
    return math.pi * 2 / 25 * _random.nextInt(25);
  }

  Offset getRandomOffset() {
    var dx = _random.nextDouble() + 10;
    var dy = _random.nextDouble() + 15;
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
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //  Center(
          // child:
          SlideTransition(position: _animationOffset, child: ball.createBall()),
          //),
          RaisedButton(
            child: Text('SPIN'),
            onPressed: setNewPosition,
          )
        ],
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
