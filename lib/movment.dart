import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Movment extends StatefulWidget {
  @override
  _MovmentState createState() => _MovmentState();
}

class _MovmentState extends State<Movment> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    // #docregion addListener
    animation = Tween<double>(begin: 0, end: 600).animate(controller)
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
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
