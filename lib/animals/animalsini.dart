import 'package:ini/ini.dart';
import 'dart:async';
import 'dart:io';

import 'animal.dart';

class AnimalsIni {
  String _path;
  Config _config;
  String _imageMap;

  AnimalsIni(this._path);

  Future<void> load() async {
    File file = await File(_path);
    List<String> lines = await file.readAsLines();
    _config = await Config.fromStrings(lines);
  }

  String _picturePath() {
    if (_imageMap==null && _config.hasOption("config", "picturemap")) {
      _imageMap = _config.get("config", "picturemap");
    }
    return _imageMap;
  }

  int size() {
    if (_config.hasOption("config", "count")) {
      return int.parse(_config.get("config", "count"));
    }
    return 0;
  }

  Animal getAnimal(int nr) {
    if (_config.hasSection("animal-"+nr.toString())) {
      return Animal(_config.items("animal-"+nr.toString()), _picturePath());
    }
    return null;
  }
}

