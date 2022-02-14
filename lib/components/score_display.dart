import 'package:flutter/painting.dart';
import '../langaw_game.dart';

class ScoreDisplay {
  final LangawGame game;

  TextPainter painter;
  TextStyle style;
  Offset position;

  ScoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    style = const TextStyle(color: Color(0xffffffff), fontSize: 90, shadows: [
      Shadow(
        blurRadius: 7,
        color: Color(0xffffffff),
        offset: Offset(3, 3),
      ),
    ]);

    position = Offset.zero;
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void update(double t) {
    if (painter.text.toString() != game.score.toString()) {
      painter.text = TextSpan(
        text: game.score.toString(),
        style: style,
      );

      painter.layout();

      position = Offset(
        (game.screenSize.width / 2) - (painter.width / 2),
        (game.screenSize.height * .25) - (painter.height / 2),
      );
    }
  }
}
