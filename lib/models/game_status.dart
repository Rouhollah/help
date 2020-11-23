import 'package:flutter/material.dart';
import 'package:help/models/ball.dart';
import 'package:help/models/level.dart';

import 'box.dart';

class GameStatus extends ChangeNotifier {
  bool started = false;
  bool firstShoot = false;
  Offset _ballPostion;
  Offset _cursorPosition;
  List keisOfBoxes = new List();
  List<Box> boxes = new List<Box>();
  List<Box> _boxes = new List<Box>();
  List<Level> levelsList = new List<Level>();
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

  /// transition position موقعیت توپ بر اساس
  void setBallPosition(Offset position) {
    _ballPostion = Offset(position.dx / Ball().width, position.dy / Ball().width);
  }

  /// Height Transition دریافت موقعیت توپ براساس
  getBallPosition() => _ballPostion;

  /// ست کردن موقعیت کرسر در هر لحظه
  void setCursorPosition(dx, dy) {
    this._cursorPosition = Offset(dx, dy);
  }

  /// دریافت موقعیت کرسر در هر لحظه
  Offset getCursorPosition() {
    return _cursorPosition;
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
