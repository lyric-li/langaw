import 'dart:ui';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flame/sprite.dart';

import '../utils.dart';
import './fly.dart';
import '../langaw_game.dart';

class HungryFly extends Fly {
  // int value = 1;

  @override
  double get speed => game.tileSize * 1;

  HungryFly(LangawGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.1, game.tileSize * 1.1);

    initSprite();
  }

  void initSprite() async {
    flyingSprite = List<Sprite>.empty(growable: true);

    final sp_1 = await loadSprite('flies/hungry-fly-1.png');
    final sp_2 = await loadSprite('flies/hungry-fly-2.png');
    flyingSprite.add(sp_1);
    flyingSprite.add(sp_2);

    deadSprite = await loadSprite('flies/hungry-fly-dead.png');
  }
}
