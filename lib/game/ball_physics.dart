import 'dart:math';
import '../core/game_config.dart';

class BallPhysics {
  double x, y;
  double vx, vy;
  double gravity;
  int score;
  final double radius;
  double screenW, screenH;
  final Random _random;

  BallPhysics({
    required this.screenW,
    required this.screenH,
  })  : x = screenW / 2,
        y = screenH / 3,
        vx = GameConfig.horizontalDrift,
        vy = 0,
        gravity = GameConfig.startGravity,
        score = 0,
        radius = GameConfig.ballRadius,
        _random = Random();

  void reset() {
    x = screenW / 2;
    y = screenH / 3;
    vx = GameConfig.horizontalDrift;
    vy = 0;
    gravity = GameConfig.startGravity;
    score = 0;
  }

  void tap() {
    vy = GameConfig.tapImpulse;
    vx += (_random.nextDouble() - 0.5) * 2 * GameConfig.tapHorizontalVariance;
  }

  void update(double dt) {
    gravity = GameConfig.startGravity + GameConfig.gravityIncrementPerScore * score;
    vy += gravity * dt;
    x += vx * dt;
    y += vy * dt;

    if (x - radius <= 0) {
      x = radius;
      vx = vx.abs();
    } else if (x + radius >= screenW) {
      x = screenW - radius;
      vx = -vx.abs();
    }

    if (y - radius <= 0) {
      y = radius;
      vy = vy.abs();
    }
  }

  bool get isBelowScreen => y - radius > screenH;

  int get displayScore => score;
}
