import 'dart:math';

import 'package:flutter/material.dart';
import 'package:help/trackFinger.dart';

class CustomTable extends StatefulWidget {
  @override
  _CustomTableState createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  Random random = new Random();
  Offset offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    // final data = InheritedProvider.of(context).inheritedData;
    // print("$data");
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Flutter Table - tutorialkart.com'),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white, size: 14),
        leading: MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30.0,
          ),
        ),
      ),
      body: _body(),
    ));
  }

  Widget _body() {
    int rowCount = generateRandomNumber(min: 5, max: 10);
    List<Container> containers = new List<Container>();
    for (var i = 0; i < rowCount; i++) {
      Row row = createRowWithrandomColumns();
      // for (int j = 0; j < row.children.length; j++) {
      //   var key = new GlobalKey();
      //   row.children[j].key = key;
      // }

      Container container = new Container(
        child: row,
      );
      containers.add(container);
    }
    return Column(children: [
      Column(children: [
        ...containers,
      ]),
      Spacer(),
      SizedBox(
        height: 70,
        child: TrackFinger(),
      ),
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
