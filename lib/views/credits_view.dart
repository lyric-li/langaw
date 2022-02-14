import 'dart:ui';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flame/sprite.dart';
import '../langaw_game.dart';

class CreditsView {
  final LangawGame game;

  late Rect rect;
  late Sprite sprite;

  CreditsView(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * .5,
      (game.screenSize.height / 2) - (game.tileSize * 6),
      game.tileSize * 8,
      game.tileSize * 12,
    );
    sprite = Sprite('ui/dialog-credits.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }
}
