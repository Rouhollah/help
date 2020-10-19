import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:help/models/ball.dart';

import 'models/values/device.dart';

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
  GlobalKey key = new GlobalKey();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
    print(key);
    new Future.delayed(Duration.zero, () {
      RenderBox rb = key.currentContext.findRenderObject();
      final Offset localOffset = rb.localToGlobal(Offset.zero);
      print("localDx:${localOffset.dx}");
      print("localDy:${localOffset.dy}");
      print("localOffset:$localOffset");
    });
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _tweenOffset = Tween<Offset>(
        begin: Offset(19, 31.888),
        end: Offset(
            (Screen.screenWidth - (Screen.screenWidth - 100)) / ball.width,
            105 / ball.width)
        // begin: Offset.zero,
        // end: Offset(19, 31.888)
        );
    _animationOffset = _tweenOffset.animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    print("width screen:${MediaQuery.of(context).size.width}");
    print("height screen:${MediaQuery.of(context).size.height}");
    print("PixelRatio:${window.devicePixelRatio}");
    print("عرض فیزیکی صفحه:${window.physicalSize.width}");
    print("ارتفاع فیزیکی صفحه:${window.physicalSize.height}");
    print("عرض متناسب:${MediaQuery.of(context).size.width / ball.width}");
    print("ارتفاع متناسب:${MediaQuery.of(context).size.height / ball.width}");

    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.yellow)),
      child: Stack(children: [
        Positioned(
            top: 0,
            left: 100,
            child:
                Container(key: key, width: 50, height: 50, color: Colors.red)),
        Positioned(
            top: 55,
            left: 100,
            child: Container(width: 50, height: 50, color: Colors.green)),
        SlideTransition(position: _animationOffset, child: ball.createBall()),
      ]),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}
