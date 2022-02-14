// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import './fly.dart';
import '../view.dart';
import '../utils.dart';

class Callout {
  final Fly fly;

  late Rect rect;
  late Sprite sprite;

  late TextPainter painter;
  TextStyle? style;
  late Offset offset;
  late double value;

  Callout(this.fly) {
    sprite = Sprite('ui/callout.png');
    value = 6;

    rect = Rect.fromLTWH(
      0,
      0,
      fly.game.tileSize * .75,
      fly.game.tileSize * .75,
    );

    offset = Offset.zero;

    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    style = const TextStyle(
      color: Color(0xff000000),
      fontSize: 15,
    );

    painter.text = TextSpan(
      text: '10',
      style: style,
    );
    painter.layout();
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
    try {
      painter.paint(c, offset);
    } catch (e) {
      printLog(e);
    }
  }

  void update(double t) {
    if (fly.game.isPlaying) {
      value = value - t;
      // value = value - .15 * t;
      // print('倒计时 $t');
      // print('倒计时 $value');
      if (value <= 1) {
        fly.game.updateActiveView(View.lost);

        if (fly.game.soundButton.isEnabled) {
          Flame.audio.play(
              'sfx/haha' + (fly.game.rand.nextInt(5) + 1).toString() + '.mp3');
        }

        // fly.game.playHomeBGM();
      }
    }

    rect = Rect.fromLTWH(
      fly.flyRect.left - (fly.game.tileSize * .25),
      fly.flyRect.top - (fly.game.tileSize * .5),
      fly.game.tileSize * .75,
      fly.game.tileSize * .75,
    );

    painter.text = TextSpan(
      text: (value).toInt().toString(),
      // text: (value * 10 ~/ 2 + 1).toInt().toString(),
      style: style,
    );
    painter.layout();

    offset = Offset(
      rect.center.dx - (painter.width / 2),
      rect.top + (rect.height * .4) - (painter.height / 2),
    );
  }
}
