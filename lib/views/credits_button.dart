import 'dart:ui';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flame/sprite.dart';
import '../langaw_game.dart';
import '../view.dart';

class CreditsButton {
  final LangawGame game;

  late Rect rect;
  late Sprite sprite;

  CreditsButton(this.game) {
    rect = Rect.fromLTWH(
      game.screenSize.width - (game.tileSize * 1.25),
      game.screenSize.height - (game.tileSize * 1.25),
      game.tileSize,
      game.tileSize,
    );
    sprite = Sprite('ui/icon-credits.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void onTapDown() {
    game.activeView = View.credits;
  }
}
