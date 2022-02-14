import 'dart:ui';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flame/sprite.dart';

import './fly.dart';
import '../langaw_game.dart';

class HungryFly extends Fly {
  // int value = 1;

  @override
  double get speed => game.tileSize * 1;

  HungryFly(LangawGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.1, game.tileSize * 1.1);

    flyingSprite = List<Sprite>.empty(growable: true);
    flyingSprite.add(Sprite('flies/hungry-fly-1.png'));
    flyingSprite.add(Sprite('flies/hungry-fly-2.png'));
    deadSprite = Sprite('flies/hungry-fly-dead.png');
  }
}
