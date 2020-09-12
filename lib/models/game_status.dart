import 'package:flutter/material.dart';

class GameStatus extends ChangeNotifier {
  bool started;
  Offset ballPostion;
  double topPositionOfCursor;
  double leftPositionOfCursor;

  GameStatus(this.started, this.ballPostion, this.leftPositionOfCursor,
      this.topPositionOfCursor);

  GameStatus getStatus() {
    return new GameStatus(
        started, ballPostion, leftPositionOfCursor, topPositionOfCursor);
  }

  colide() {
    notifyListeners();
  }
}
