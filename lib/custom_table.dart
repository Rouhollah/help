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
      //TrackFinger(),
      SizedBox(
        height: 70,
        child: TrackFinger(),
      ),
    ]);
  }

  /// ایجاد یک ردیف با تعداد ستون تصادفی
  Widget createRowWithrandomColumns() {
    List<Widget> cols = randomColumns();
    return Row(mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.end,
        //mainAxisSize: MainAxisSize.max,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
      var key = new GlobalKey(debugLabel: i.toString());
      Column col = Column(
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

  Container blueCursor() {
    return Container(
      width: 100.0,
      height: 20,
      color: Colors.blue[100],
    );
  }

//   Widget dragCorsur() {
//     return new GestureDetector(
//       onTapDown: (TapDownDetails details) => onTapDown(context, details),
//       child: new Stack(fit: StackFit.expand, children: <Widget>[
//         // Hack to expand stack to fill all the space. There must be a better
//         // way to do it.
//         new Container(
//           height: 200,
//           color: Colors.green,
//         ),
//         new Positioned(
//           child: cursor(),
//           left: posx,
//           top: posy,
//         )
//       ]),
//     );
//   }

//   void onTapDown(BuildContext context, TapDownDetails details) {
//     final RenderBox box = context.findRenderObject();
//     final Offset localOffset = box.globalToLocal(details.globalPosition);
//     setState(() {
//       double rEdge = calculateSpaceToEdges();
//       posx = localOffset.dx >= rEdge ? rEdge : localOffset.dx;
//       posy = MediaQuery.of(context).size.height - 100;
//     });
//   }

//   Container cursor() {
//     return Container(
//       color: Colors.brown[300],
//       height: 20,
//       width: 100,
//     );
//   }

//   calculateSpaceToEdges() {
//     double rightEdge = MediaQuery.of(context).size.width - 100.toDouble();
//     return rightEdge;
//   }
}
