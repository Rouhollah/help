import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Movment extends StatefulWidget {
  @override
  _MovmentState createState() => _MovmentState();
}

class _MovmentState extends State<Movment> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  Animation<Offset> _animationOffset;
  Tween<double> _tween;
  Tween<Offset> _tweenOffset;
  AnimationController _animationController;
  math.Random _random = math.Random();
  int position = 0;

  double getRandomAngle() {
    return math.pi * 2 / 25 * _random.nextInt(25);
  }

  Offset getRandomOffset() {
    print(Offset(_random.nextDouble(), _random.nextDouble()));
    return Offset(_random.nextDouble(), _random.nextDouble());
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
    _tweenOffset = Tween<Offset>(begin: Offset(0, 0), end: getRandomOffset());
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
          children: <Widget>[
            Center(
                //   child: Transform.rotate(
                // angle: _animation.value,
                child: SlideTransition(
              position: _animationOffset,
              child: Icon(
                Icons.arrow_upward,
                size: 250.0,
              ),
            )),
            Expanded(
              child: Container(),
            ),
            RaisedButton(
              child: Text('SPIN'),
              onPressed: setNewPosition,
            )
          ],
        ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
