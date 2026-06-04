import 'package:flutter/material.dart';

import '../core/game_config.dart';
import '../core/game_logger.dart';

enum SkinType { image, color }

class BallSkinManager extends ChangeNotifier {
  int _selectedIndex = 0;
  SkinType _skinType = SkinType.image;

  int get selectedIndex => _selectedIndex;
  SkinType get skinType => _skinType;
  int get selectedColor => GameConfig.ballColors[_selectedIndex];
  String get selectedName => _names[_selectedIndex];
  String? get selectedImagePath => _skinType == SkinType.image
      ? GameConfig.ballSkinAssets[_selectedIndex]
      : null;
  List<int> get allColors => GameConfig.ballColors;
  List<String> get allNames => _names;
  List<String> get allImagePaths => GameConfig.ballSkinAssets;
  String get selectedImageName => GameConfig.ballSkinNames[_selectedIndex];
  List<String> get allImageNames => GameConfig.ballSkinNames;

  static const _names = ['Forest', 'Amber', 'Gray', 'Green', 'Olive'];

  void select(int index) {
    if (index >= 0 && index < GameConfig.ballColors.length) {
      _selectedIndex = index;
      GameLogger.action('Skin selected: ${_names[index]}');
      notifyListeners();
    }
  }

  void setSkinType(SkinType type) {
    if (_skinType != type) {
      _skinType = type;
      GameLogger.action('Skin type: ${type.name}');
      notifyListeners();
    }
  }

  void toggleSkinType() {
    setSkinType(_skinType == SkinType.image ? SkinType.color : SkinType.image);
  }
}
