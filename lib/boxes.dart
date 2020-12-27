import 'dart:math';

import 'package:flutter/material.dart';
import 'package:help/models/box.dart';
import 'package:help/models/game_status.dart';
import 'package:help/models/type_box.dart';
import 'package:provider/provider.dart';

import 'models/level.dart';
import 'models/values/device.dart';

class Boxes extends StatefulWidget {
  final Level level;
  Boxes(this.level);

  @override
  _BoxesState createState() => _BoxesState();
}

class _BoxesState extends State<Boxes> {
  Random random = new Random();
  List<Widget> lst = new List();
  List<TypeBox> boxOfLevel = new List<TypeBox>();

  @override
  void initState() {
    super.initState();
    var g = Provider.of<GameStatus>(context, listen: false);
    Level level = g.levelsList.firstWhere((element) => element.level == widget.level.level, orElse: () => null);

    // اضافه نشده بود ، اضافه کن provider قبلا به level اگر
    if (level == null) {
      g.levelsList.add(widget.level);
      for (var level in g.levelsList) {
        for (var item in level.boxes) {
          Box b = new Box(type: item.type, x: item.x, y: item.y);
          g.setBoxes(b);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //return createBoard();
    return constantBox();
  }

  Widget constantBox() {
    final game = Provider.of<GameStatus>(context);
    // نمایش باکسهای هر مرحله
    // for (var item in game.getBoxes()) {
    //   var positioned = new Positioned(
    //       top: item.position.dy, left: item.position.dx, child: item.create());
    //   lst.add(positioned);
    // }
    return Selector<GameStatus, List<Box>>(
      selector: (buildContext, geme) => game.getBoxes(),
      builder: (context, boxes, child) {
        lst = [];
        Positioned positioned;
        for (var item in boxes) {
          positioned = new Positioned(top: item.position.dy, left: item.position.dx, child: item.create());
          lst.add(positioned);
        }
        return Container(
            child: Stack(children: [
          ...lst,
        ]));
      },
    );

    // return Container(
    //     //padding: EdgeInsets.only(top: 60),
    //     child: Stack(children: [
    //   ...lst,
    // ]));
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
