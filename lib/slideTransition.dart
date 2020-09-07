import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:help/models/ball.dart';

class SlideWidget extends StatefulWidget {
  @override
  _SlideWidgetState createState() => _SlideWidgetState();
}

class _SlideWidgetState extends State<SlideWidget>
    with SingleTickerProviderStateMixin {
  Animation<Offset> _animationOffset;
  Tween<Offset> _tweenOffset;
  AnimationController _animationController;
  Ball ball = new Ball();

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _tweenOffset = Tween<Offset>(begin: Offset.zero, end: Offset(20.6, 36.4));
    _animationOffset = _tweenOffset.animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    print("width screen:${MediaQuery.of(context).size.width}");
    print("عرض متناسب:${MediaQuery.of(context).size.width / ball.width}");
    print("ارتفاع متناسب:${MediaQuery.of(context).size.height / ball.height}");
    return SafeArea(
      bottom: true,
      top: true,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.yellow)),
        child: Stack(children: [
          SlideTransition(position: _animationOffset, child: ball.createBall()),
        ]),
      ),
    );
  }
}
