import 'dart:convert';

import 'package:help/models/box.dart';
import 'package:help/repository/load_level_repo.dart';

class LoadLevelService {
  List<Box> listBox = new List<Box>();
  LoadLevelRepository loadLevelRepository = new LoadLevelRepository();

  /// json شده از decode برگرداندن فایل
  parseJson() async {
    String jsonString = await loadLevelRepository.loadFromAsset();
    var result = json.decode(jsonString);
    return result;
  }
}
