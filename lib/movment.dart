import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class Movment extends StatefulWidget {
  @override
  _MovmentState createState() => _MovmentState();
}

class _MovmentState extends State<Movment> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  Offset _start = Offset(0, 0);
  Offset _end = Offset(0.5, -0.4);

  @override
  void initState() {
    super.initState();
    // controller =
    //     AnimationController(duration: const Duration(seconds: 2), vsync: this);
    // // #docregion addListener
    // animation = Tween<double>(begin: 0, end: 600).animate(controller)
    //   ..addListener(() {
    //     // #enddocregion addListener
    //     setState(() {
    //       // The state that has changed here is the animation object’s value.
    //       print(animation.value);
    //     });
    //     // #docregion addListener
    //   });
    // // #enddocregion addListener
    // controller.forward();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation =
        Tween<Offset>(begin: _start, end: _end).animate(_animationController);

    _animationController.forward().whenComplete(() {
      // put here the stuff you wanna do when animation completed!
    });
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
    // return Stack(
    //   // fit: StackFit.expand,
    //   children: [
    //     Positioned(
    //       top: _top,
    //       left: _left,
    //       child: Container(
    //         width: 50,
    //         height: 50,
    //         color: Colors.green[100],
    //       ),
    //     ),
    //     RaisedButton(
    //       onPressed: move,
    //       child: Container(
    //         alignment: Alignment.center,
    //         color: Colors.green,
    //         width: 100,
    //         height: 50,
    //         child: Text(
    //           "move",
    //           style: TextStyle(color: Colors.white, fontSize: 16.0),
    //         ),
    //       ),
    //     )
    //   ],
    // );
    return SafeArea(
        child: SlideTransition(
      position: _animation,
      child: Center(child: Text("My Text")),
    ));
  }

  // move() {
  //   setState(() {
  //     _top = 300.0;
  //     _left = 400.0;
  //   });
  // }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
