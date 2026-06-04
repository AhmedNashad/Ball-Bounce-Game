import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../core/asset_loader.dart';
import '../core/game_config.dart';
import '../core/game_logger.dart';
import 'background_manager.dart';
import 'ball_painter.dart';
import 'ball_physics.dart';
import 'ball_skin_manager.dart';

enum GameState { idle, playing, gameOver }

class GameScreen extends StatefulWidget {
  final BallSkinManager skinManager;
  final BackgroundManager bgManager;
  const GameScreen({
    super.key,
    required this.skinManager,
    required this.bgManager,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  late BallPhysics _physics;
  GameState _state = GameState.idle;
  int _finalScore = 0;
  double _pulsePhase = 0;
  Duration _lastTime = Duration.zero;

  ui.Image? _ballImage;
  ui.Image? _bgImage;

  @override
  void initState() {
    super.initState();
    widget.skinManager.addListener(_onSkinChanged);
    widget.bgManager.addListener(_onBgChanged);
    _physics = BallPhysics(screenW: 0, screenH: 0);
    _ticker = createTicker(_onTick);
    _loadCurrentImages();
    GameLogger.stateChange('initializing', 'idle');
  }

  @override
  void dispose() {
    widget.skinManager.removeListener(_onSkinChanged);
    widget.bgManager.removeListener(_onBgChanged);
    _ticker.dispose();
    super.dispose();
  }

  void _onSkinChanged() {
    _loadBallImage();
    setState(() {});
  }

  void _onBgChanged() {
    _loadBgImage();
    setState(() {});
  }

  Future<void> _loadCurrentImages() async {
    await Future.wait([_loadBallImage(), _loadBgImage()]);
    if (mounted) setState(() {});
  }

  Future<void> _loadBallImage() async {
    final path = widget.skinManager.selectedImagePath;
    if (path != null) {
      try {
        _ballImage = await AssetImageLoader.load(path);
      } catch (_) {
        _ballImage = null;
      }
    } else {
      _ballImage = null;
    }
  }

  Future<void> _loadBgImage() async {
    final path = widget.bgManager.selectedImagePath;
    try {
      _bgImage = await AssetImageLoader.loadBackground(path);
    } catch (_) {
      _bgImage = null;
    }
  }

  void _onTick(Duration elapsed) {
    final dt = _lastTime == Duration.zero
        ? 1 / 60.0
        : (elapsed - _lastTime).inMicroseconds / 1000000.0;
    _lastTime = elapsed;

    switch (_state) {
      case GameState.idle:
        _pulsePhase += GameConfig.idleBounceSpeed * dt;
        setState(() {});
        break;
      case GameState.playing:
        _physics.update(dt);
        if (_physics.isBelowScreen) {
          _finalScore = _physics.displayScore;
          _state = GameState.gameOver;
          _ticker.stop();
          GameLogger.stateChange('playing', 'gameOver');
          GameLogger.info('Final score: $_finalScore');
        }
        setState(() {});
        break;
      case GameState.gameOver:
        break;
    }
  }

  void _onTapDown(TapDownDetails details) {
    switch (_state) {
      case GameState.idle:
        final dx = details.localPosition.dx - _physics.x;
        final dy = details.localPosition.dy - _physics.y;
        final dist = sqrt(dx * dx + dy * dy);
        if (dist <= _physics.radius + 10) {
          _physics.vy = 0;
          _physics.tap();
          _state = GameState.playing;
          _lastTime = Duration.zero;
          _ticker.start();
          GameLogger.stateChange('idle', 'playing');
          GameLogger.action('First tap');
        }
        break;
      case GameState.playing:
        final dx = details.localPosition.dx - _physics.x;
        final dy = details.localPosition.dy - _physics.y;
        final dist = sqrt(dx * dx + dy * dy);
        if (dist <= _physics.radius + 10) {
          _physics.tap();
          _physics.score++;
          GameLogger.action('Tap #${_physics.score}');
        }
        break;
      case GameState.gameOver:
        _physics.reset();
        _state = GameState.idle;
        _lastTime = Duration.zero;
        GameLogger.stateChange('gameOver', 'idle');
        setState(() {});
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _physics.screenW = constraints.maxWidth;
        _physics.screenH = constraints.maxHeight;
        if (_state == GameState.idle && _physics.x == 0) {
          _physics.x = constraints.maxWidth / 2;
          _physics.y = constraints.maxHeight / 3;
        }

        String? overlay;
        String? scoreText;
        switch (_state) {
          case GameState.idle:
            overlay = GameConfig.idleText;
            break;
          case GameState.playing:
            scoreText = '${GameConfig.scorePrefix}${_physics.score}';
            break;
          case GameState.gameOver:
            overlay =
                '${GameConfig.gameOverText}\n${GameConfig.scorePrefix}$_finalScore';
            break;
        }

        return GestureDetector(
          onTapDown: _onTapDown,
          child: CustomPaint(
            painter: BallPainter(
              ballX: _physics.x,
              ballY: _physics.y,
              ballRadius: GameConfig.ballRadius,
              ballColor: widget.skinManager.selectedColor,
              ballImage: _ballImage,
              backgroundImage: _bgImage,
              overlayText: overlay,
              scoreText: scoreText,
              showIdlePulse: _state == GameState.idle,
              pulsePhase: _pulsePhase,
            ),
            size: Size.infinite,
          ),
        );
      },
    );
  }
}
