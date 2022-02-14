import 'dart:ui';

import 'package:flame/sprite.dart';

import './fly.dart';
import '../langaw_game.dart';

class HouseFly extends Fly {
  // int value = 3;

  @override
  double get speed => game.tileSize * 3;

  HouseFly(LangawGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1, game.tileSize * 1);

    flyingSprite = List<Sprite>.empty(growable: true);
    flyingSprite.add(Sprite('flies/house-fly-1.png'));
    flyingSprite.add(Sprite('flies/house-fly-2.png'));
    deadSprite = Sprite('flies/house-fly-dead.png');
  }
}
