import 'package:flutter/material.dart';

import '../core/game_config.dart';
import '../core/game_logger.dart';

class BackgroundManager extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  String get selectedImagePath => GameConfig.backgroundAssets[_selectedIndex];
  String get selectedName => GameConfig.backgroundNames[_selectedIndex];
  List<String> get allPaths => GameConfig.backgroundAssets;
  List<String> get allNames => GameConfig.backgroundNames;

  void select(int index) {
    if (index >= 0 && index < GameConfig.backgroundAssets.length) {
      _selectedIndex = index;
      GameLogger.action(
        'Background selected: ${GameConfig.backgroundNames[index]}',
      );
      notifyListeners();
    }
  }
}
