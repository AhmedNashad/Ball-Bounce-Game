# 🏀 Ball Bounce Game

A sleek, no‑dependency ball bouncing game built with **Flutter** and **Dart** – no external game engines, no extra packages, just pure Flutter SDK.  
Tap the ball to keep it in the air, watch gravity increase with every hit, and compete for the highest score.

## ✨ Features

- **Pure Flutter** – zero third‑party dependencies (no Flame, no game engine).
- **60 fps game loop** – powered by Flutter’s `Ticker`.
- **Physics‑based movement** – gravity, velocity, wall bouncing, and random horizontal taps.
- **Progressive difficulty** – gravity increases by `15 px/s²` with each point.
- **Three game states** – Idle (pulsing ball), Playing, Game Over.
- **Customizable ball skins**:
  - 5 solid colors (Forest, Amber, Gray, Green, Olive).
  - 5 image skins (baseball, volleyball, tennis ball, football, basketball).
- **Customizable backgrounds** – 5 scenic images (Dark, Space, Neon City, Sunset, Abstract) with solid fallbacks.
- **Asset caching** – images are loaded once and cached in memory.
- **Responsive UI** – adapts text scaling and layout to any screen size.
- **Tap anywhere to reset** after Game Over.

---

## 🎮 How to Play

1. **Start** – Tap the ball when it’s centered and pulsing.
2. **Keep it up** – Tap the ball again to make it jump. Each successful tap adds 1 point.
3. **Survive** – Gravity gets stronger with every point. The ball also drifts rightward.
4. **Game Over** – If the ball falls below the screen, the game ends.
5. **Play again** – Tap anywhere on the screen to return to the idle state.

> **Tip**: The faster you tap, the longer you survive – but beware of the increasing gravity!

---

## 🖼️ Customization

Tap the **🎨 palette icon** in the top‑right corner to open the asset selector.  
You can change:

- **Ball Color** – choose from 5 solid colors.
- **Ball Skin** – switch to one of 5 image‑based balls (cached for performance).
- **Background** – pick from 5 background images (or their fallback solid colors).

Changes apply immediately without restarting the game.

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.44.0 or later)
- [Dart SDK](https://dart.dev/get-dart) (version 3.12.0 or later)
- An IDE (VS Code, Android Studio, or IntelliJ)

### Installation

```bash
# Clone the repository
git clone https://github.com/AhmedNashad/Ball-Bounce-Game.git
cd ball-bounce-game

# Fetch dependencies (none besides Flutter, but run this anyway)
flutter pub get

# Run the app
flutter run
