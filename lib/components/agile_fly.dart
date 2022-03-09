import 'dart:ui';

import 'package:flame/sprite.dart';
import '../utils.dart';
import './fly.dart';
import '../langaw_game.dart';

class AgileFly extends Fly {
  @override
  // ignore: overridden_fields
  int value = 5;

  @override
  double get speed => game.tileSize * value;

  AgileFly(LangawGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1, game.tileSize * 1);

    initSprite();
  }

  void initSprite() async {
    flyingSprite = List<Sprite>.empty(growable: true);

    final sp_1 = await loadSprite('flies/agile-fly-1.png');
    final sp_2 = await loadSprite('flies/agile-fly-2.png');
    flyingSprite.add(sp_1);
    flyingSprite.add(sp_2);

    deadSprite = await loadSprite('flies/agile-fly-dead.png');
  }
}
