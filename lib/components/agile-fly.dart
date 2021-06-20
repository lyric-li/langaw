import 'dart:ui';

import 'package:flame/sprite.dart';

import './fly.dart';
import '../langaw-game.dart';

class AgileFly extends Fly {

  int value = 5;

  double get speed => game.tileSize * 5;

  AgileFly(LangawGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1, game.tileSize * 1);

    flyingSprite = List<Sprite>.empty(growable: true);
    flyingSprite.add(Sprite('flies/agile-fly-1.png'));
    flyingSprite.add(Sprite('flies/agile-fly-2.png'));
    deadSprite = Sprite('flies/agile-fly-dead.png');
  }
}
