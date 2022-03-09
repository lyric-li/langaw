import 'dart:ui';

import 'package:flame/sprite.dart';

import '../utils.dart';
import './fly.dart';
import '../langaw_game.dart';

class HouseFly extends Fly {
  @override
  // ignore: overridden_fields
  int value = 1;

  @override
  double get speed => game.tileSize * value;

  HouseFly(LangawGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1, game.tileSize * 1);

    initSprite();
  }

  void initSprite() async {
    flyingSprite = List<Sprite>.empty(growable: true);

    final sp_1 = await loadSprite('flies/house-fly-1.png');
    final sp_2 = await loadSprite('flies/house-fly-2.png');
    flyingSprite.add(sp_1);
    flyingSprite.add(sp_2);

    deadSprite = await loadSprite('flies/house-fly-dead.png');
  }
}
