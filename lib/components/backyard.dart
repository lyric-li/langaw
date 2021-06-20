import 'dart:ui';

import 'package:flame/sprite.dart';

import '../langaw-game.dart';

class Backyard {
  Sprite bgSprite;
  Rect bgRect;

  Backyard(LangawGame game) {
    bgSprite = Sprite('bg/backyard.png');

    bgRect = Rect.fromLTWH(
      0,
      game.screenSize.height - (game.tileSize * 23),
      game.tileSize * 9,
      game.tileSize * 23,
    );
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}
}
