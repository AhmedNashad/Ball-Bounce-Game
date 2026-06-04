import 'package:flutter/material.dart';

import '../core/game_config.dart';
import '../game/background_manager.dart';
import '../game/ball_skin_manager.dart';

class AssetSelector extends StatelessWidget {
  final BallSkinManager skinManager;
  final BackgroundManager bgManager;
  final VoidCallback onClose;

  const AssetSelector({
    super.key,
    required this.skinManager,
    required this.bgManager,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader('Ball Colors'),
          const SizedBox(height: 8),
          _buildColorSkins(),
          const Divider(color: Colors.white12, height: 24),
          _buildHeader('Ball Skins'),
          const SizedBox(height: 8),
          _buildImageSkins(),
          const Divider(color: Colors.white12, height: 24),
          _buildHeader('Backgrounds'),
          const SizedBox(height: 8),
          _buildBackgrounds(),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        const SizedBox(width: 24),
        GestureDetector(
          onTap: onClose,
          child: const Icon(Icons.close, color: Colors.white54, size: 18),
        ),
      ],
    );
  }

  Widget _buildColorSkins() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(GameConfig.ballColors.length, (i) {
        final isSelected =
            i == skinManager.selectedIndex &&
            skinManager.skinType == SkinType.color;
        return GestureDetector(
          onTap: () {
            skinManager.select(i);
            skinManager.setSkinType(SkinType.color);
            onClose();
          },
          child: Container(
            margin: const EdgeInsets.all(3),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(skinManager.allColors[i]),
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(color: Colors.white, width: 2)
                        : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  skinManager.allNames[i],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white54,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildImageSkins() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(GameConfig.ballSkinAssets.length, (i) {
        final isSelected =
            i == skinManager.selectedIndex &&
            skinManager.skinType == SkinType.image;
        return GestureDetector(
          onTap: () {
            skinManager.select(i);
            skinManager.setSkinType(SkinType.image);
            onClose();
          },
          child: Container(
            margin: const EdgeInsets.all(3),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(color: Colors.white, width: 2)
                        : Border.all(color: Colors.white12),
                    image: DecorationImage(
                      image: AssetImage(GameConfig.ballSkinAssets[i]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  skinManager.allImageNames[i],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white54,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBackgrounds() {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: List.generate(GameConfig.backgroundAssets.length, (i) {
        final isSelected = i == bgManager.selectedIndex;
        return GestureDetector(
          onTap: () {
            bgManager.select(i);
            onClose();
          },
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: isSelected
                  ? Border.all(color: Colors.white, width: 2)
                  : Border.all(color: Colors.white12),
              image: DecorationImage(
                image: AssetImage(GameConfig.backgroundAssets[i]),
                fit: BoxFit.cover,
              ),
            ),
            child: isSelected
                ? const Center(
                    child: Icon(Icons.check, color: Colors.white, size: 18),
                  )
                : null,
          ),
        );
      }),
    );
  }


}
