import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import '../langaw_game.dart';
import './callout.dart';
import '../utils.dart';

class Fly {
  final LangawGame game;

  Rect flyRect;
  // Paint flyPaint;
  List<Sprite> flyingSprite = [];
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  bool isDead = false;
  bool isOffScreen = false;
  Offset targetLocation;
  Callout callout;

  int value = 1;
  double get speed => game.tileSize * 3;

  Fly(this.game) {
    // flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);

    // flyPaint = Paint();
    // flyPaint.color = Color(0xff6ab04c);
    setTargetLocation();
    callout = Callout(this);
  }

  void render(Canvas c) {
    // c.drawRect(flyRect, flyPaint);
    if (isDead) {
      // 绘制飞蝇死亡图像
      deadSprite.renderRect(c, flyRect.inflate(flyRect.width / 2));
    } else {
      // 绘制飞蝇飞行图像
      try {
        flyingSprite[flyingSpriteIndex.toInt()]
            .renderRect(c, flyRect.inflate(flyRect.width / 2));
      } catch (e) {
        printLog(e);
      }
      if (game.isPlaying) {
        callout.render(c);
      }
    }
  }

  void update(double t) {
    if (isDead) {
      // 飞蝇坠落
      flyRect = flyRect.translate(0, game.tileSize * 12 * t);
    } else {
      // 飞行动画
      flyingSpriteIndex += 30 * t;
      while (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }

      // 计算飞蝇行动轨迹
      double stepDistance = speed * t;
      Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget =
            Offset.fromDirection(toTarget.direction, stepDistance);
        flyRect = flyRect.shift(stepToTarget);
      } else {
        flyRect = flyRect.shift(toTarget);
        setTargetLocation();
      }

      callout.update(t);
    }

    // 飞蝇超出屏幕
    if (flyRect.top > game.screenSize.height) {
      isOffScreen = true;
    }
  }

  void onTapDown(int score) {
    // flyPaint.color = Color(0xffff4757);
    isDead = true;
    // game.spawnFly();
    game.updateScore(score);

    if (game.soundButton.isEnabled) {
      Flame.audio
          .play('sfx/ouch' + (game.rand.nextInt(11) + 1).toString() + '.mp3');
    }
  }

  void setTargetLocation() {
    double x = game.rand.nextDouble() *
        (game.screenSize.width - (game.tileSize * 1.35));
    double y = (game.rand.nextDouble() *
            (game.screenSize.height - (game.tileSize * 2.85))) +
        (game.tileSize * 1.5);
    targetLocation = Offset(x, y);
  }
}
