import 'package:flutter/material.dart';

import 'ball.dart';

class GameStart extends StatefulWidget {
  @override
  _GameStartState createState() => _GameStartState();
}

class _GameStartState extends State<GameStart>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  Offset _start = Offset(0, 0);
  Offset _end = Offset(0.0, -0.4);

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    // #docregion addListener
    animation = Tween<Offset>(begin: _start, end: _end).animate(controller)
      ..addListener(() {
        // #enddocregion addListener
        setState(() {
          // The state that has changed here is the animation object’s value.
          print(animation.value);
        });
        // #docregion addListener
      });
    // #enddocregion addListener
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Ball ball = new Ball();
    return SafeArea(
        child: SlideTransition(
            position: animation,
            child: Container(
              width: ball.width,
              height: ball.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green[400],
              ),
            )));
  }

  @override
  void dispose() {
    // _animationController.dispose();
    controller.dispose();
    super.dispose();
  }
}
