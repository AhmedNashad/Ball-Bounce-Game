import 'package:flutter/foundation.dart';

class GameLogger {
  GameLogger._();

  static void info(String message) {
    final timestamp = DateTime.now().toIso8601String();
    debugPrint('[$timestamp] [INFO] $message');
  }

  static void stateChange(String from, String to) {
    info('STATE: $from → $to');
  }

  static void action(String label) {
    info('ACTION: $label');
  }

  static void error(String message) {
    final timestamp = DateTime.now().toIso8601String();
    debugPrint('[$timestamp] [ERROR] $message');
  }
}
