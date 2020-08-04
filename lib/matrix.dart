import 'package:flutter/material.dart';

class Matrix extends StatefulWidget {
  @override
  _MatrixState createState() => _MatrixState();
}

class _MatrixState extends State<Matrix> {
  List<List<ColumnData>> gameBoard = new List(3);
  @override
  void initState() {
    super.initState();
    print('Lets build matrix');
    initGame();
  }

  Widget _buildBody() {
    List<Widget> rows = new List<Widget>(gameBoard.length);
    for (int i = 0; i < gameBoard.length; i++) {
      List<Widget> cols = new List<Widget>(gameBoard[i].length);
      for (int j = 0; j < gameBoard[i].length; j++) {
        cols[j] = gameBoard[i][j].column;
      }
      rows[i] = new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: cols,
      );
    }

    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rows,
      ),
    );
  }

  initGame() {
    List<ColumnData> row1Data = [];
    List<ColumnData> row2Data = [];
    List<ColumnData> row3Data = [];
    ColumnData colData00 = new ColumnData(row: 0, col: 0, data: '7');
    row1Data.add(colData00);
    gameBoard[0] = row1Data;
    ColumnData colData10 = new ColumnData(row: 1, col: 0, data: '5');
    ColumnData colData11 = new ColumnData(row: 1, col: 1, data: '2');
    row2Data.add(colData10);
    row2Data.add(colData11);
    gameBoard[1] = row2Data;
    ColumnData colData20 = new ColumnData(row: 2, col: 0, data: '3');
    ColumnData colData21 = new ColumnData(row: 2, col: 1, data: '2');
    ColumnData colData22 = new ColumnData(row: 2, col: 2, data: '0');
    row3Data.add(colData20);
    row3Data.add(colData21);
    row3Data.add(colData22);
    gameBoard[2] = row3Data;
    print(gameBoard);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Matrix'),
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
        body: _buildBody());
  }
}

class ColumnData {
  int _rowIdx;
  int _colIdx;
  String _data;
  Widget _column;

  ColumnData({String data, int row, int col}) {
    _data = data;
    _rowIdx = row;
    _colIdx = col;
    _column = new InkWell(
      child: new Container(
        margin: new EdgeInsets.all(8.0),
        child: new SizedBox(
          width: 50.0,
          height: 50.0,
          child: new Text(
            _data,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        decoration: new BoxDecoration(
          border: new Border.all(color: Colors.indigoAccent, width: 2.0),
          shape: BoxShape.rectangle,
        ),
      ),
    );
  }
  set data(String value) => _data = value;
  set colIdx(int value) => _colIdx = value;
  set rowIdx(int value) => _rowIdx = value;
  Widget get column => _column;
  String get data => _data;
  int get colIdx => _colIdx;
  int get rowIdx => _rowIdx;
  String toString() {
    return ('Row: $_rowIdx Col: $_colIdx Data: $_data');
  }
}
