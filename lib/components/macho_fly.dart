import 'dart:ui';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flame/sprite.dart';

import '../utils.dart';
import './fly.dart';
import '../langaw_game.dart';

class MachoFly extends Fly {
  @override
  // ignore: overridden_fields
  int value = 4;

  @override
  double get speed => game.tileSize * value;

  MachoFly(LangawGame game, double x, double y) : super(game) {
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.35, game.tileSize * 1.35);

    initSprite();
  }

  void initSprite() async {
    flyingSprite = List<Sprite>.empty(growable: true);

    final sp_1 = await loadSprite('flies/macho-fly-1.png');
    final sp_2 = await loadSprite('flies/macho-fly-2.png');
    flyingSprite.add(sp_1);
    flyingSprite.add(sp_2);

    deadSprite = await loadSprite('flies/macho-fly-dead.png');
  }
}
