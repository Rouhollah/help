import 'dart:math';

import 'package:flutter/material.dart';

class TablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Draggable',
        home: Scaffold(
          body: CustomTable(),
        ));
  }
}

class CustomTable extends StatefulWidget {
  @override
  _CustomTableState createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  Random random = new Random();
  double top = 0;
  double left = 0;
  Offset offset = Offset.zero;
  @override
  Widget build(BuildContext context) {
    // return Stack(
    //   children: <Widget>[
    //     Positioned(
    //       left: offset.dx,
    //       top: offset.dy,
    //       child: GestureDetector(
    //         onPanUpdate: (details) {
    //           setState(() {
    //             offset = Offset(
    //                 offset.dx + details.delta.dx, offset.dy + details.delta.dy);
    //             print(offset);
    //           });
    //         },
    //         child: Container(width: 100, height: 100, color: Colors.blue),
    //       ),
    //     ),
    //   ],
    // );
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
    return Column(
      children: [
        ...containers,
        Spacer(),
        dragCursor(),
        SizedBox(
          height: 25,
        )
      ],
    );
  }

  dragCursor() {
    return Draggable(
      child: Container(
        padding: EdgeInsets.only(top: top, left: left),
        width: 100.0,
        height: 20,
        color: Colors.green,
        child: DragItem(),
      ),
      feedback: DragItem(),
      childWhenDragging: DragItem(),
      // maxSimultaneousDrags: 1,
      axis: Axis.horizontal,
      onDragCompleted: () {},
      onDragEnd: (drag) {
        print(left);
        print("-------------");
        //setState(() {
        // top = drag.offset.dy;
        left = drag.offset.dx;
        //});
        print(drag);
        print(left);
      },
    );
  }

  /// ایجاد ردیفهایی با تعداد تصادفی
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
}

class DragItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return blueCursor();
  }

  Container blueCursor() {
    return Container(
      width: 100.0,
      height: 20,
      color: Colors.blue[100],
    );
  }
}
