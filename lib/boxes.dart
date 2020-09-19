import 'dart:math';

import 'package:flutter/material.dart';

import 'models/values/device.dart';

class Boxes extends StatefulWidget {
  @override
  _BoxesState createState() => _BoxesState();
}

class _BoxesState extends State<Boxes> {
  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    return createBoard();
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
    int cols = generateRandomNumber();
    List<Widget> columns = new List<Widget>();
    double side = Screen.screenWidth / 11;
    for (var i = 0; i < cols; i++) {
      // var _key = new GlobalKey(debugLabel: i.toString());
      GlobalKey _key = new GlobalKey();
      Column col = Column(
        key: _key,
        children: [
          Container(
            height: side,
            width: side,
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
