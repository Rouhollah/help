import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:help/ball.dart';
import 'package:help/cursor.dart';
import 'package:help/movement.dart';
import 'package:help/trackFinger.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> with TickerProviderStateMixin {
  double screenWidth;
  double screenHeigth;
  Random random = new Random();
  Ball ball = new Ball();
  Cursor cursor = new Cursor();

  Animation<Offset> _animationOffset;
  AnimationController _animationController;
  Tween<Offset> _tweenOffset;

  double posX;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    _tweenOffset =
        Tween<Offset>(begin: Offset(0.0, 0.0), end: getRandomOffset());
    _animationOffset = _tweenOffset.animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    print("initState");

//دسترسی به  content
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Schedule code execution once after the frame has rendered
      // print(MediaQuery.of(context).size.toString());
    });
    //or
    // new Future.delayed(Duration.zero, () {
    //       // Schedule a zero-delay future to be executed
    //       print(MediaQuery.of(context).size.toString());
    //   });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeigth = MediaQuery.of(context).size.height;
    print("screenWidthInBuildMethod");
    posX = screenWidth / 2 - 50;
    return SafeArea(
      top: true,
      bottom: true,
      child: createBoard(),
    );
  }

  Widget createBoard() {
    int rowCount = generateRandomNumber(min: 2, max: 4);
    List<Container> containers = new List<Container>();
    for (var i = 0; i < rowCount; i++) {
      Row row = createRowWithrandomColumns();
      Container container = new Container(
        child: row,
      );
      containers.add(container);
    }
    return Column(children: [
      ...containers,
      Spacer(),
      SizedBox(
          height: 120,
          child: GestureDetector(
              onTapDown: (details) {},
              child: new Stack(children: <Widget>[
                new Container(
                  color: Colors.purple,
                ),
                new Positioned(
                  child: cursor.createCursor(), //createCursor(),
                  left: posX,
                  top: cursor.height * 3,
                ),
              ]))),
    ]);
  }

  Offset getRandomOffset() {
    int w = (((window.physicalSize.width / window.devicePixelRatio) / 2) / 2)
        .round();
    int h = (((window.physicalSize.height / window.devicePixelRatio) / 2) / 2)
        .round();
    var dx = generateRandomNumber(min: -7, max: 6);
    var dy = generateRandomNumber(min: -5, max: 15);
    // var dy = 0.0;
    print("Offset($dx,$dy)");
    return Offset(dx.toDouble(), dy.toDouble());
  }

  void setNewPosition() {
    _tweenOffset.begin = _tweenOffset.end;
    _animationController.reset();
    _tweenOffset.end = getRandomOffset();
    _animationController.forward();
  }

  /// ایجاد یک ردیف با تعداد ستون تصادفی
  Widget createRowWithrandomColumns() {
    List<Widget> cols = randomColumns();
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ...cols,
      SizedBox(
        width: 5,
        height: 10,
      )
    ]);
  }

  /// ایجاد ستون هایی با تعداد و رنگ تصادفی همراه با فاصله بین آنها ، عمودی و افقی
  List<Widget> randomColumns() {
    int cols = generateRandomNumber(min: 3, max: 5);
    List<Widget> columns = new List<Widget>();
    for (var i = 0; i < cols; i++) {
      // var _key = new GlobalKey(debugLabel: i.toString());
      GlobalKey _key = new GlobalKey();
      Column col = Column(
        key: _key,
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            color: Color.fromRGBO(
              random.nextInt(256),
              random.nextInt(256),
              random.nextInt(256),
              1,
            ),
          ),
          // ایجاد فاصله عمودی بین هر ایتم
          SizedBox(
            height: 5,
          )
        ],
      );
      //ایجاد فاصله بین هر ستون
      SizedBox sBox = SizedBox(width: 5);
      columns.add(col);
      columns.add(sBox);
    }
    return columns;
  }

  /// ایجاد عدد تصادفی در یک رنج
  int generateRandomNumber({min = 1, max = 10}) {
    int num = min + random.nextInt(max - min);
    return num;
  }
}
