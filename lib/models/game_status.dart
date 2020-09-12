import 'package:flutter/material.dart';

class GameStatus extends ChangeNotifier {
  bool started;
  Offset ballPostion;
  double topPositionOfCursor;
  double leftPositionOfCursor;

  GameStatus(this.started, this.ballPostion, this.leftPositionOfCursor,
      this.topPositionOfCursor);

  colide() {
    notifyListeners();
  }
}
