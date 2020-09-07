import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:help/movement.dart';
import 'package:help/services/inherited_provider.dart';
import 'package:help/trackFinger.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> with TickerProviderStateMixin {
  // double screenWidth;
  // double screenHeigth;
  Random random = new Random();

  @override
  void initState() {
    super.initState();
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
    // screenWidth = MediaQuery.of(context).size.width;
    // screenHeigth = MediaQuery.of(context).size.height;

    return SafeArea(
      top: true,
      bottom: true,
      child: Stack(children: [
        TrackFinger(),
        createBoard(),
        Movement(),
      ]),
    );
  }

  Widget createBoard() {
    int rowCount = generateRandomNumber(min: 1, max: 10);
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
      //Spacer(),
      //SizedBox(height: 120, child: TrackFinger()),
    ]);
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
          // ایجاد فاصله افقی بین هر ایتم
          SizedBox(
            height: 5,
          )
        ],
      );
      //ایجاد فاصله عمودی بین هر ستون
      SizedBox sBox = SizedBox(width: 5);
      columns.add(col);
      columns.add(sBox);
    }
    return columns;
  }

  calculateSpaceToEdges() {
    double rightEdge = MediaQuery.of(context).size.width - 100.toDouble();
    return rightEdge;
  }

  /// ایجاد عدد تصادفی در یک رنج
  int generateRandomNumber({min = 1, max = 10}) {
    int num = min + random.nextInt(max - min);
    return num;
  }
}
