import 'dart:convert';

import 'package:flutter/services.dart';

class LoadLevelApi {
  /// خواندن فایل جیسون
  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/levels.json");
  }

  /// json شده از decode برگرداندن فایل
  Future parseJson() async {
    String jsonString = await _loadFromAsset();
    var result = json.decode(jsonString);
    return result;
  }
}
