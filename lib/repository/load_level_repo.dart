import 'package:flutter/services.dart';
import 'package:help/models/level.dart';

class LoadLevelRepository {
  /// خواندن فایل جیسون
  Future<String> loadFromAsset() async {
    return await rootBundle.loadString("assets/levels.json");
  }
}
