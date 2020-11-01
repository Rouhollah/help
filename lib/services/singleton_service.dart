import 'package:help/services/load_level_api.dart';

class SingletonService {
  LoadLevelApi _loadLevelApi;
  static final SingletonService _instance = SingletonService._internal();

  static SingletonService instance = SingletonService();

  factory SingletonService() {
    return _instance;
  }

  SingletonService._internal();

  loadLevel() {
    String jsonLevels;
    _loadLevelApi.parseJson().then((value) {
      jsonLevels = value;
      return jsonLevels;
    });
  }
}
