import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:help/models/game_status.dart';
import 'package:provider/provider.dart';

import 'models/values/device.dart';

class Boxes extends StatefulWidget {
  @override
  _BoxesState createState() => _BoxesState();
}

class _BoxesState extends State<Boxes> {
  Random random = new Random();

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      var g = Provider.of<GameStatus>(context, listen: false);
      var boxes = g.getAllBox();
      for (var box in boxes) {
        RenderBox rb = box.key.currentContext.findRenderObject();
        final Offset localOffset = rb.localToGlobal(Offset.zero);
        box.position = localOffset;
        box.width = rb.size.width;
        box.height = rb.size.width;
        box.size = rb.size;
      }
      g.boxes = boxes;
    });
  }

  @override
  Widget build(BuildContext context) {
    //return createBoard();
    return constantBox();
  }

  Widget constantBox() {
    List kies = new List();
    double side = Screen.screenWidth / 10;
    for (var i = 0; i < 3; i++) {
      GlobalKey _key = new GlobalKey();
      kies.add(_key);
      Provider.of<GameStatus>(context, listen: false).allKeisOfBoxes(_key);
    }
    return Container(
      //padding: EdgeInsets.only(top: 60),
      child: Stack(
        children: [
          Positioned(
            top: 100,
            left: 177,
            child: Column(
              key: kies[0],
              children: [
                Container(
                  width: side,
                  height: side,
                  color: Colors.red,
                )
              ],
            ),
          ),
          Positioned(
            top: 200,
            left: 200,
            child: Column(
              key: kies[1],
              children: [
                Container(
                  width: side,
                  height: side,
                  color: Colors.green,
                )
              ],
            ),
          ),
          Positioned(
            top: 300,
            left: 100,
            child: Column(
              key: kies[2],
              children: [
                Container(
                  width: side,
                  height: side,
                  color: Colors.blue,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// ایجاد مربع های تصادفی برای شروع بازی
  Widget createBoard() {
    // تعداد ردیف تصادفی است rowCount ،ایجاد عدد تصادفی برای تعداد ردیف
    int rowCount = generateRandomNumber(min: 1, max: 10);
    List<Container> containers = new List<Container>();
    for (var i = 0; i < rowCount; i++) {
      Row row = createRowWithrandomColumns();
      Container container = new Container(
        child: row,
      );
      containers.add(container);
    }
    // getAllPositionOfBoxes(containers);
    //Provider.of<GameStatus>(context, listen: false).allBoxPosition(containers);
    return Column(children: [
      ...containers,
    ]);
  }

  /// ایجاد یک ردیف با تعداد ستون تصادفی
  Row createRowWithrandomColumns() {
    List<Widget> cols = randomColumns();
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ...cols,
      // SizedBox(
      //   width: 5,
      //   height: 10,
      // )
    ]);
  }

  /// ایجاد ستون هایی با تعداد و رنگ تصادفی همراه با فاصله بین آنها ، عمودی و افقی
  List<Widget> randomColumns() {
    // تعداد ستون تصادفی است cols
    int cols = generateRandomNumber();
    List<Widget> columns = new List<Widget>();
    double side = Screen.screenWidth / 10;
    for (var i = 0; i < cols; i++) {
      // var _key = new GlobalKey(debugLabel: i.toString());
      GlobalKey _key = new GlobalKey();
      Provider.of<GameStatus>(context, listen: false).allKeisOfBoxes(_key);
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
      SizedBox sBox = SizedBox(width: 1);
      columns.add(col);
      columns.add(sBox);
    }
    return columns;
  }

  /// ایجاد عدد تصادفی در یک رنج ، پیشفرض بین یک تا 10 است
  int generateRandomNumber({min = 1, max = 10}) {
    int num = min + random.nextInt(max - min);
    return num;
  }
}
