import 'dart:convert';

import 'package:help/repository/load_level_repo.dart';

class LoadLevelApi {
  LoadLevelRepository loadLevelRepository = new LoadLevelRepository();

  /// json شده از decode برگرداندن فایل
  Future parseJson() async {
    String jsonString = await loadLevelRepository.loadFromAsset();
    var result = json.decode(jsonString);
    return result;
  }
}
