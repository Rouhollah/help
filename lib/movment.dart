import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Movment extends StatefulWidget {
  @override
  _MovmentState createState() => _MovmentState();
}

class _MovmentState extends State<Movment> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController controller;
  Animation _animation;
  Animation animation;
  double _top = 80;
  double _left = 150;
  Rect r1 = new Rect.fromLTRB(50, 50, 100, 100);
  Rect r2 = new Rect.fromLTRB(300, 300, 350, 350);
  //Rect r2 = new Rect.fromCenter();

  Offset _start = Offset(0, 0);
  Offset _end = Offset(0.0, -0.4);

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    // #docregion addListener
    animation = RectTween(begin: r1, end: r2).animate(controller)
      ..addListener(() {
        // #enddocregion addListener
        setState(() {
          // The state that has changed here is the animation object’s value.
          print(animation.value);
          // print(animation);
        });
        // #docregion addListener
      });
    // #enddocregion addListener
    controller.forward();
    //controller.repeat();
    // _animationController =
    //     AnimationController(vsync: this, duration: Duration(seconds: 2));
    // _animation =
    //     Tween<Offset>(begin: _start, end: _end).animate(_animationController);

    // _animationController.forward().whenComplete(() {
    //   // put here the stuff you wanna do when animation completed!
    // });
  }

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Container(
    //     margin: EdgeInsets.symmetric(vertical: 10),
    //     height: animation.value,
    //     width: animation.value,
    //     child: FlutterLogo(),
    //   ),
    // );
    return Stack(
      // fit: StackFit.expand,
      children: [
        Positioned.fromRect(
          rect: r1,
          //top: _top,
          //left: _left,
          child: Container(
            // width: 50,
            // height: 50,
            color: Colors.green[100],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
            onPressed: move,
            child: Container(
              alignment: Alignment.center,
              color: Colors.green,
              width: 100,
              height: 50,
              child: Text(
                "move",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
        )
      ],
    );
    // return SafeArea(
    //     child: SlideTransition(
    //   position: _animation,
    //   child: Center(
    //       child: Text(
    //     "My Text",
    //     style: TextStyle(fontSize: 20),
    //   )),
    // ));
  }

  move() {
    setState(() {
      // _top = 160;
      // _left = 300;
      r1 = r2;
    });
  }

  @override
  void dispose() {
    // _animationController.dispose();
    controller.dispose();
    super.dispose();
  }
}
