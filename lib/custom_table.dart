import 'dart:math';

import 'package:flutter/material.dart';

class CustomTable extends StatefulWidget {
  @override
  _CustomTableState createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  Random random = new Random();

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
            body: _body()));
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
        SizedBox(
          height: 300,
        ),
        Container(
          width: 100.0,
          height: 20,
          color: Colors.green,
        )
      ],
    );
  }

  /// create row with random count column
  Widget createRowWithrandomColumns() {
    List<Column> cols = randomColumns();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: cols,
    );
  }

  List<Column> randomColumns() {
    int cols = generateRandomNumber();
    //int count = generateRandomNumber();
    //List<Container> containers = new List<Container>();
    //for (var i = 0; i < count; i++) {}
    //createContainer();
    List<Column> columns = new List<Column>();
    for (var i = 0; i < cols; i++) {
      Column col = Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenl,
        //crossAxisAlignment: CrossAxisAlignment.start,
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
          )
        ],
      );
      columns.add(col);
    }
    return columns;
  }

  Widget createContainer() {
    return Container(
      height: 50.0,
      width: 50.0,
      color: Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      ),
    );
  }

  int generateRandomNumber({min = 1, max = 10}) {
    int num = min + random.nextInt(max - min);
    return num;
  }
}
