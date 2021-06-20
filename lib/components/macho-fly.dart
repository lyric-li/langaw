import 'dart:ui';

import 'package:flame/sprite.dart';

import './fly.dart';
import '../langaw-game.dart';

class MachoFly extends Fly {

  int value = 4;

  double get speed => game.tileSize * 4;

  MachoFly(LangawGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.35, game.tileSize * 1.35);

    flyingSprite = List<Sprite>.empty(growable: true);
    flyingSprite.add(Sprite('flies/macho-fly-1.png'));
    flyingSprite.add(Sprite('flies/macho-fly-2.png'));
    deadSprite = Sprite('flies/macho-fly-dead.png');
  }
}
