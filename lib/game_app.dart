import 'package:flutter/material.dart';

import 'game/background_manager.dart';
import 'game/ball_skin_manager.dart';
import 'game/game_screen.dart';
import 'widgets/asset_selector.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  final _skinManager = BallSkinManager();
  final _bgManager = BackgroundManager();
  bool _showMenu = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ball Bounce',
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          GameScreen(skinManager: _skinManager, bgManager: _bgManager),
          Positioned(
            top: 48,
            right: 16,
            child: GestureDetector(
              onTap: () => setState(() => _showMenu = !_showMenu),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.palette_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
          if (_showMenu)
            Positioned(
              top: 96,
              right: 16,
              child: AssetSelector(
                skinManager: _skinManager,
                bgManager: _bgManager,
                onClose: () => setState(() => _showMenu = false),
              ),
            ),
        ],
      ),
    );
  }
}
