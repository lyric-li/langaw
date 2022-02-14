import 'dart:ui';

import 'package:flame/sprite.dart';

import './fly.dart';
import '../langaw_game.dart';

class DroolerFly extends Fly {
  // int value = 2;

  @override
  double get speed => game.tileSize * 2;

  DroolerFly(LangawGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1, game.tileSize * 1);

    flyingSprite = List<Sprite>.empty(growable: true);
    flyingSprite.add(Sprite('flies/drooler-fly-1.png'));
    flyingSprite.add(Sprite('flies/drooler-fly-2.png'));
    deadSprite = Sprite('flies/drooler-fly-dead.png');
  }
}
