import 'package:flutter/painting.dart';
import '../langaw_game.dart';

class HighscoreDisplay {
  final LangawGame game;

  TextPainter painter;
  TextStyle style;
  Offset position;

  HighscoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    Shadow shadow = const Shadow(
      blurRadius: 3,
      color: Color(0xff000000),
      offset: Offset.zero,
    );

    style = TextStyle(
      color: const Color(0xffffffff),
      fontSize: 30,
      shadows: [shadow, shadow, shadow, shadow],
    );

    position = Offset.zero;

    update();
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update() {
    int highscore = game.storage.getInt('highscore') ?? 0;

    painter.text = TextSpan(
      text: 'Highest score: ' + highscore.toString(),
      style: style,
    );

    painter.layout();

    position = Offset(
      game.screenSize.width - (game.tileSize * .25) - painter.width,
      game.tileSize * .25,
    );
  }
}
