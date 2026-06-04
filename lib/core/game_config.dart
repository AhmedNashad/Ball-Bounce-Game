class GameConfig {
  GameConfig._();

  static const double ballRadius = 20;
  static const double startGravity = 500;
  static const double gravityIncrementPerScore = 15;
  static const double horizontalDrift = 120;
  static const double tapImpulse = -400;
  static const double tapHorizontalVariance = 60;
  static const double idleBounceAmplitude = 5;
  static const double idleBounceSpeed = 1.5;

  static const List<int> ballColors = [
    0xFF304936,
    0xFFD19A40,
    0xFF5E5E5C,
    0xFF388E3C,
    0xFF706C4E,
  ];

  static const List<String> ballSkinAssets = [
    'assets/images/balls/base-ball.png',
    'assets/images/balls/volley-ball.png',
    'assets/images/balls/tennis-ball.png',
    'assets/images/balls/football.png',
    'assets/images/balls/basket-ball.png',
  ];

  static const List<String> ballSkinNames = [
    'base-ball',
    'volley-ball',
    'tennis-ball',
    'football',
    'basket-ball',
  ];

  static const List<String> backgroundAssets = [
    'assets/images/backgrounds/base-ball_court.jpg',
    'assets/images/backgrounds/basketball_court.jpg',
    'assets/images/backgrounds/football_field.jpg',
    'assets/images/backgrounds/tennis_court.jpg',
    'assets/images/backgrounds/vollyball_court.jpg',
  ];

  static const List<String> backgroundNames = [
    'baseball Court',
    'basketball Court',
    'football Field',
    'tennis Court',
    'volleyball Court',
  ];

  static const String idleText = 'Tap the Ball to Start';
  static const String gameOverText = 'Game Over';
  static const String scorePrefix = 'Score: ';
}
