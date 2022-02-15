import 'dart:ui';
import 'package:flame/sprite.dart';
import '../langaw_game.dart';
import '../utils.dart';

class Backyard {
  late Sprite bgSprite;
  late Rect bgRect;

  Backyard(LangawGame game) {
    initBgSprite();

    bgRect = Rect.fromLTWH(
      0,
      game.screenSize.height - (game.tileSize * 23),
      game.tileSize * 9,
      game.tileSize * 23,
    );
  }

  void initBgSprite() async {
    bgSprite = await loadSprite('bg/backyard.png');
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}
}
