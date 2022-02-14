import 'dart:ui';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flame/sprite.dart';
import '../langaw_game.dart';

class SoundButton {
  final LangawGame game;

  late Rect rect;
  late Sprite enabledSprite;
  late Sprite disabledSprite;

  bool isEnabled = true;

  SoundButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * 1.5,
      game.tileSize * .25,
      game.tileSize,
      game.tileSize,
    );
    enabledSprite = Sprite('ui/icon-sound-enabled.png');
    disabledSprite = Sprite('ui/icon-sound-disabled.png');
  }

  void render(Canvas c) {
    if (isEnabled) {
      enabledSprite.renderRect(c, rect);
    } else {
      disabledSprite.renderRect(c, rect);
    }
  }

  void onTapDown() {
    isEnabled = !isEnabled;
  }
}
