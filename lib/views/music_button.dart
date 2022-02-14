import 'dart:ui';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flame/sprite.dart';
import '../langaw_game.dart';

class MusicButton {
  final LangawGame game;

  late Rect rect;
  late Sprite enabledSprite;
  late Sprite disabledSprite;

  bool isEnabled = true;

  MusicButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * .25,
      game.tileSize * .25,
      game.tileSize,
      game.tileSize,
    );
    enabledSprite = Sprite('ui/icon-music-enabled.png');
    disabledSprite = Sprite('ui/icon-music-disabled.png');
  }

  void render(Canvas c) {
    if (isEnabled) {
      enabledSprite.renderRect(c, rect);
    } else {
      disabledSprite.renderRect(c, rect);
    }
  }

  void onTapDown() async {
    if (isEnabled) {
      isEnabled = false;
      // await game.homeBGM.setVolume(0);
      // await game.playingBGM.setVolume(0);
      // game.homeBGM.pause();
      // game.playingBGM.pause();
      game.bgm.pause();
    } else {
      isEnabled = true;
      // await game.homeBGM.setVolume(.25);
      // await game.playingBGM.setVolume(.25);
      // game.homeBGM.resume();
      // game.playingBGM.resume();
      game.bgm.resume();
    }
  }
}
