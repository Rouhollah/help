import 'package:flutter/services.dart';

class LoadLevelRepository {
  /// خواندن فایل جیسون
  Future<String> loadFromAsset() async {
    return await rootBundle.loadString("assets/levels.json");
  }
}
