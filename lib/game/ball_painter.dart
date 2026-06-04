import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../core/game_config.dart';

class BallPainter extends CustomPainter {
  final double ballX;
  final double ballY;
  final double ballRadius;
  final int ballColor;
  final ui.Image? ballImage;
  final ui.Image? backgroundImage;
  final int backgroundColor;
  final String? overlayText;
  final String? scoreText;
  final bool showIdlePulse;
  final double pulsePhase;

  BallPainter({
    required this.ballX,
    required this.ballY,
    required this.ballRadius,
    required this.ballColor,
    this.ballImage,
    this.backgroundImage,
    this.backgroundColor = 0xFF0C0F0B,
    this.overlayText,
    this.scoreText,
    this.showIdlePulse = false,
    this.pulsePhase = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (backgroundImage != null) {
      paintImage(canvas, backgroundImage!, Offset.zero & size);
    } else {
      final bgPaint = Paint()..color = Color(backgroundColor);
      canvas.drawRect(Offset.zero & size, bgPaint);
    }

    final r = showIdlePulse
        ? ballRadius + GameConfig.idleBounceAmplitude * sin(pulsePhase)
        : ballRadius;

    if (ballImage != null) {
      final dstRect = Rect.fromCenter(
        center: Offset(ballX, ballY),
        width: r * 2,
        height: r * 2,
      );
      paintImage(canvas, ballImage!, dstRect);
    } else {
      final ballPaint = Paint()
        ..color = Color(ballColor)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(ballX, ballY), r, ballPaint);

      final highlightPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(ballX - r * 0.3, ballY - r * 0.3),
        r * 0.35,
        highlightPaint,
      );
    }

    if (scoreText != null) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: scoreText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, const Offset(16, 48));
    }

    if (overlayText != null) {
      final tp = TextPainter(
        text: TextSpan(
          text: overlayText,
          style: TextStyle(
            color: Colors.white.withValues(alpha: showIdlePulse ? 0.9 : 0.6),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset((size.width - tp.width) / 2, size.height * 0.75));
    }
  }

  void paintImage(Canvas canvas, ui.Image image, Rect dstRect) {
    final srcRect = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final paint = Paint()
      ..filterQuality = FilterQuality.high;
    canvas.drawImageRect(image, srcRect, dstRect, paint);
  }

  @override
  bool shouldRepaint(covariant BallPainter oldDelegate) =>
      oldDelegate.ballX != ballX ||
      oldDelegate.ballY != ballY ||
      oldDelegate.ballColor != ballColor ||
      oldDelegate.ballImage != ballImage ||
      oldDelegate.backgroundImage != backgroundImage ||
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.overlayText != overlayText ||
      oldDelegate.scoreText != scoreText ||
      oldDelegate.showIdlePulse != showIdlePulse ||
      oldDelegate.pulsePhase != pulsePhase;
}
