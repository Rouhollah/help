import 'dart:math';

import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return createBoard();
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
    getAllPositionOfBoxes();
    Provider.of<GameStatus>(context, listen: false).allBoxPosition(containers);
    return Column(children: [
      ...containers,
    ]);
  }

  getAllPositionOfBoxes(container) {
    List<Offset> allPosition = new List<Offset>();
    for (var box in container) {
      RenderBox box = context.findRenderObject();
      Offset localOffset = box.globalToLocal(Offset.zero);
      allPosition.add(localOffset);
    }
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
    double side = Screen.screenWidth / 11;
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
      SizedBox sBox = SizedBox(width: 5);
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
