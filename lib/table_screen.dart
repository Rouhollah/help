import 'package:flutter/material.dart';

class MyTable extends StatefulWidget {
  @override
  _MyTableState createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  double iconSize = 40;

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
          body: Center(
              child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Table(
                border: TableBorder.all(),
                // ستون با عرض های مختلف
                columnWidths: {
                  0: FractionColumnWidth(.4),
                  1: FractionColumnWidth(.2),
                  2: FractionColumnWidth(.4)
                },
                children: [
                  TableRow(children: [
                    Column(children: [
                      Icon(
                        Icons.account_box,
                        size: iconSize,
                      ),
                      Text('My Account')
                    ]),
                    Column(children: [
                      Icon(
                        Icons.settings,
                        size: iconSize,
                      ),
                      Text('Settings')
                    ]),
                    Column(children: [
                      Icon(
                        Icons.lightbulb_outline,
                        size: iconSize,
                      ),
                      Text('Ideas')
                    ]),
                  ]),
                  TableRow(children: [
                    Icon(
                      Icons.cake,
                      size: iconSize,
                    ),
                    Icon(
                      Icons.voice_chat,
                      size: iconSize,
                    ),
                    Icon(
                      Icons.add_location,
                      size: iconSize,
                    ),
                  ]),
                ],
              ),
            ),
          ]))),
    );
  }
}
