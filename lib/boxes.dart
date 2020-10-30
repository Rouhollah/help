import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:help/models/box.dart';
import 'package:help/models/game_status.dart';
import 'package:provider/provider.dart';

import 'models/level.dart';
import 'models/values/device.dart';

class Boxes extends StatefulWidget {
  @override
  _BoxesState createState() => _BoxesState();
}

class _BoxesState extends State<Boxes> {
  Random random = new Random();
  List<Box> listBox = new List();
  List<Widget> lst = new List();

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () async {
      var g = Provider.of<GameStatus>(context, listen: false);
      var jsonLevels = await parseJson();
      var rest = jsonLevels['levels'] as List;
      var list = rest.map<Level>((json) => Level.fromJson(json)).toList();
      var levelBoxes = list.where((p) => p.passed == false).first;
      for (var box in levelBoxes.boxes) {
        Box b = new Box(type: box.type, x: box.x, y: box.y);
        g.setBoxes(b);
      }
      listBox = g.getBoxes();
    });
  }

  /// خواندن فایل جیسون
  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/levels.json");
  }

  /// json شده از decode برگرداندن فایل
  Future parseJson() async {
    String jsonString = await _loadFromAsset();
    return json.decode(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    //return createBoard();
    return constantBox();
  }

  Widget constantBox() {
    for (var item in listBox) {
      var positioned = new Positioned(
          top: item.position.dx, left: item.position.dy, child: item.create());
      lst.add(positioned);
    }
    return Container(
        //padding: EdgeInsets.only(top: 60),
        child: Stack(
      children: [...lst],
    ));
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
