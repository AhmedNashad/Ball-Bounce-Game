import 'dart:ui' as ui;

import 'package:flutter/services.dart';

import 'game_logger.dart';

class AssetImageLoader {
  AssetImageLoader._();

  static final Map<String, ui.Image> _cache = {};

  static Future<ui.Image> load(String assetPath) async {
    if (_cache.containsKey(assetPath)) {
      return _cache[assetPath]!;
    }
    try {
      final data = await rootBundle.load(assetPath);
      final codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetHeight: 160,
        targetWidth: 160,
      );
      final frame = await codec.getNextFrame();
      _cache[assetPath] = frame.image;
      GameLogger.info('Loaded image: $assetPath');
      return frame.image;
    } catch (e) {
      GameLogger.error('Failed to load image $assetPath: $e');
      rethrow;
    }
  }

  static Future<ui.Image> loadBackground(String assetPath) async {
    if (_cache.containsKey(assetPath)) {
      return _cache[assetPath]!;
    }
    try {
      final data = await rootBundle.load(assetPath);
      final codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
      );
      final frame = await codec.getNextFrame();
      _cache[assetPath] = frame.image;
      GameLogger.info('Loaded background: $assetPath');
      return frame.image;
    } catch (e) {
      GameLogger.error('Failed to load background $assetPath: $e');
      rethrow;
    }
  }

  static void clearCache() {
    _cache.clear();
    GameLogger.info('Image cache cleared');
  }
}
