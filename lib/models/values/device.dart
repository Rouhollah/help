import 'dart:ui';
import 'package:help/models/ball.dart';

Ball ball = new Ball();

class Screen {
  ///screen Width
  static double screenWidth =
      window.physicalSize.width / window.devicePixelRatio;

  /// screen Heith
  static double screenHeight =
      window.physicalSize.height / window.devicePixelRatio;

  ///maximum Width For Ball Transition
  static double maxWidthForBallTransition = screenWidth / ball.width;

  ///maximum Height For Ball Transition
  static double maxHeightForBallTransition = screenWidth / ball.width;
}
