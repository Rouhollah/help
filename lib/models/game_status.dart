import 'package:flutter/material.dart';

class GameStatus extends ChangeNotifier {
  bool started = false;
  bool firstShoot = false;
  Offset ballPostion;
  double topPositionOfCursor;
  double leftPositionOfCursor;

  // GameStatus(this.started, this.ballPostion, this.leftPositionOfCursor,
  //     this.topPositionOfCursor);

  GameStatus getStatus() {
    return GameStatus();

    // return new GameStatus(
    //     started, ballPostion, leftPositionOfCursor, topPositionOfCursor);
  }

  void gameStart(firstShoot) {
    this.firstShoot = firstShoot;
    this.started = firstShoot;

    print("gameStart.started:${this.started}");
    notifyListeners();
  }

  void ballPosition(Offset position) {
    this.ballPostion = position;
    notifyListeners();
  }

  void cursorPosition(dx, dy) {
    this.leftPositionOfCursor = dx;
    this.topPositionOfCursor = dy;
    notifyListeners();
  }
}
