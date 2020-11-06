import 'package:flutter/material.dart';
import 'package:help/models/ball.dart';
import 'package:help/models/level.dart';

import 'box.dart';

class GameStatus extends ChangeNotifier {
  bool started = false;
  bool firstShoot = false;
  Offset _ballPostion;
  double topPositionOfCursor;
  double leftPositionOfCursor;
  List keisOfBoxes = new List();
  List<Box> boxes = new List();
  List<Box> _boxes = new List();
  List<Level> levelsList;
  dynamic jsonLevels;

  int ballDirection;
  Box boxCollideWithBall;

  void gameStart(firstShoot) {
    this.firstShoot = firstShoot;
    this.started = firstShoot;
    print("gameStart.started:${this.started}");
    notifyListeners();
  }

  void setBoxes(Box box) {
    _boxes.add(box);
  }

  List<Box> getBoxes() => _boxes;

  removeBox() {
    _boxes.removeWhere((element) => element.key == boxCollideWithBall.key);
    boxCollideWithBall = null;
    notifyListeners();
  }

  /// موقعیت توپ در هر لحظه
  void setBallPosition(Offset position) {
    _ballPostion =
        Offset(position.dx / Ball().width, position.dy / Ball().width);
  }

  /// Height Transition دریافت موقعیت توپ براساس
  getBallPosition() => _ballPostion;

  allBoxPosition(List<Container> containers) {
    whichBoxesAreInBallRoute();
  }

  /// موقعیت کرسر در هر لحظه
  whichBoxesAreInBallRoute() {}

  void cursorPosition(dx, dy) {
    this.leftPositionOfCursor = dx;
    this.topPositionOfCursor = dy;
    //notifyListeners();
  }

  /// نگه داشتن کلیدهای همه مربع ها
  void allKeisOfBoxes(GlobalKey key) {
    keisOfBoxes.add(key);
  }

  /// لیست همه مربع ها را بر می گرداند
  List<Box> getAllBox() {
    for (var i = 0; i < keisOfBoxes.length; i++) {
      Box box = new Box();
      box.key = keisOfBoxes[i];
      boxes.add(box);
    }
    return boxes;
  }
}
