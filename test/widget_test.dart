import 'package:flutter_test/flutter_test.dart';
import 'package:ball_bounce/game_app.dart';
import 'package:ball_bounce/game/ball_skin_manager.dart';

void main() {
  group('BallSkinManager defaults', () {
    test('default skin type is image', () {
      final manager = BallSkinManager();
      expect(manager.skinType, SkinType.image);
      expect(manager.selectedIndex, 0);
      expect(manager.selectedImagePath, isNotNull);
    });

    test('image skin names are correct', () {
      final manager = BallSkinManager();
      expect(
        manager.allImageNames,
        ['base-ball', 'volley-ball', 'tennis-ball', 'football', 'basket-ball'],
      );
      expect(manager.selectedImageName, 'base-ball');
    });
  });

  testWidgets('Game app builds without error', (WidgetTester tester) async {
    await tester.pumpWidget(const GameApp());
    expect(find.byType(GameApp), findsOneWidget);
  });
}
