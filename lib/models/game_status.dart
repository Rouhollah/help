import 'package:flutter/material.dart';

import 'box.dart';

class GameStatus extends ChangeNotifier {
  bool started = false;
  bool firstShoot = false;
  Offset ballPostion;
  double topPositionOfCursor;
  double leftPositionOfCursor;
  List keisOfBoxes = new List();

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

  /// موقعیت توپ در هر لحظه
  void setBallPosition(Offset position) {
    this.ballPostion = position;
    notifyListeners();
  }

  /// موقعیت کرسر در هر لحظه
  void cursorPosition(dx, dy) {
    this.leftPositionOfCursor = dx;
    this.topPositionOfCursor = dy;
    notifyListeners();
  }

  /// نگه داشتن کلیدهای همه مربع ها
  void allKeisOfBoxes(GlobalKey key) {
    keisOfBoxes.add(key);
  }

  /// لیست همه مربع ها را بر می گرداند
  List<Box> getAllBox() {
    List<Box> lst = new List();
    for (var i = 0; i < keisOfBoxes.length; i++) {
      Box box = new Box();
      box.key = keisOfBoxes[i];
      lst.add(box);
    }
    return lst;
  }
}
