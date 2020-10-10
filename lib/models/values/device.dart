import 'dart:ui';
import 'package:help/models/ball.dart';

Ball ball = new Ball();

class Screen {
  ///عرض صفحه
  static double screenWidth =
      window.physicalSize.width / window.devicePixelRatio;

  /// ارتفاع صفحه
  static double screenHeight =
      window.physicalSize.height / window.devicePixelRatio;

  ///حذاکثر اندازه حرکت توب در عرض صفحه
  static double maxWidthForBallTransition = screenWidth / ball.width;

  ///حداکثر انازه حرکت توپ در ارتفاع صفحه
  static double maxHeightForBallTransition = screenWidth / ball.width;
}
