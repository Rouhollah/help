import 'dart:math';

import 'package:flutter/material.dart';

class TrackFinger extends StatefulWidget {
  @override
  _TrackFingerState createState() => _TrackFingerState();
}

class _TrackFingerState extends State<TrackFinger> {
  final random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Borad'),
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
        body: dynamicRows());
  }

  // rowsAndColumn() {
  //   var rowCount = this.random.nextInt(10);
  //   var colCount = this.random.nextInt(10);
  //   List<RandomTable> rowCol = new List<RandomTable>();
  //   for (var i = 0; i < rowCount;i++) {
  //     //for (var j = 0; j < colCount;j++) {
  //     //
  //     //}
  //     ListView.builder(
  //     itemBuilder: new  Card(
  //     child: Column(
  //       children: [
  //         Text(rowCol[i], style: TextStyle(color: Colors.deepPurple))
  //       ],
  //     ),
  //   );,
  //     itemCount: products.length,
  //   );

  //   }
  // }

  dynamicRows() {
    int colCount = randomNumerInRange(5, 10);
    int rowCount = randomNumerInRange(1, 10);
    print("colCount:$colCount");
    print("rowCount:$rowCount");
    // List<GridView> rows = new List<GridView>();
    // for (var i = 0; i < 3; i++) {
    //   var row =
    return GridView.count(
      crossAxisCount: colCount,
      children: List.generate(colCount, (index) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                color: Color.fromRGBO(
                  random.nextInt(256),
                  random.nextInt(256),
                  random.nextInt(256),
                  1,
                ),
              ),
            ],
          ),
          // child: Text(
          //   'Item $index',
          //   style: Theme.of(context).textTheme.headline5,
          // ),
        );
      }),
    );
    //   rows.add(row);
    // }
    // return rows;
  }

  int randomNumerInRange(min, max) {
    return min + random.nextInt(max - min);
  }
}

class RandomTable {
  int row;
  int column;
}
