import 'dart:ui';
import 'dart:math';

import 'package:flame_audio/flame_audio.dart';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:langaw/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

import './components/fly.dart';
import 'components/house_fly.dart';
import 'components/agile_fly.dart';
import 'components/drooler_fly.dart';
import 'components/hungry_fly.dart';
import 'components/macho_fly.dart';
import 'components/score_display.dart';
import 'components/highscore_display.dart';

import './controllers/spawner.dart';

import './view.dart';
import './views/backyard.dart';
import './views/home.dart';
import './views/lost.dart';
import 'views/start_button.dart';
import 'views/help_button.dart';
import 'views/credits_button.dart';
import 'views/help_view.dart';
import 'views/credits_view.dart';
import 'views/music_button.dart';
import 'views/sound_button.dart';

class LangawGame extends FlameGame with TapDetector {
  final SharedPreferences storage;

  late Size screenSize;
  late double tileSize;
  late List<Fly> flies;
  late Random rand;
  late Backyard background;
  late FlySpawner spawner;
  View activeView = View.home;
  late HomeView home;
  late LostView lost;
  late StartButton startButton;
  late HelpButton helpButton;
  late CreditsButton creditsButton;
  late MusicButton musicButton;
  late SoundButton soundButton;
  late HelpView helpView;
  late CreditsView creditsView;
  late ScoreDisplay scoreDisplay;
  late int score;
  late HighscoreDisplay highscoreDisplay;
  late AudioPlayer bgm;

  bool get isPlaying => activeView == View.playing;

  LangawGame(this.storage) {
    initialize(375, 667);
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    printLog(canvasSize.x);
    printLog(canvasSize.y);

    // resize(Size(canvasSize.x, canvasSize.y));
    initialize(canvasSize.x, canvasSize.y);
  }

  /// 初始化
  void initialize(double x, double y) async {
    flies = List<Fly>.empty(growable: true);

    // 重新计算屏幕尺寸和区块尺寸
    // Size s = Size(size.x, size.y);
    // resize(s);
    resize(Size(x, y));

    // 初始化UI
    background = Backyard(this);
    home = HomeView(this);
    lost = LostView(this);
    startButton = StartButton(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
    musicButton = MusicButton(this);
    soundButton = SoundButton(this);
    helpView = HelpView(this);
    creditsView = CreditsView(this);
    scoreDisplay = ScoreDisplay(this);
    highscoreDisplay = HighscoreDisplay(this);

    rand = Random();

    // 初始化飞蝇控制器
    spawner = FlySpawner(this);
    // spawner.start();
    // spawnFly();
    resetData();

    // 初始化音频
    // bgm = new Bgm();
    // bgm.initialize();
    // bgm.play('bgm/playing.mp3', volume: .25);

    bgm = await FlameAudio.loop('bgm/playing.mp3', volume: .25);
    // Flame.bgm.play('adventure-track.mp3');

    // playingBGM = await Flame.audio.loop('bgm/playing.mp3', volume: .25);
    // await playingBGM.pause();
    // homeBGM = await Flame.audio.loop('bgm/home.mp3', volume: 0.25);
    // await homeBGM.pause();

    // playPlayingBGM();
    // playHomeBGM();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    // Paint bgPaint = Paint();
    // bgPaint.color = Color(0xff576574);
    // canvas.drawRect(bgRect, bgPaint);
    background.render(canvas);
    musicButton.render(canvas);
    soundButton.render(canvas);

    if (isPlaying) {
      scoreDisplay.render(canvas);
      highscoreDisplay.render(canvas);
    }

    for (var fly in flies) {
      fly.render(canvas);
    }

    if (activeView == View.home) {
      home.render(canvas);
    }

    if (activeView == View.home || activeView == View.lost) {
      helpButton.render(canvas);
      creditsButton.render(canvas);
    }

    if (!isPlaying) {
      startButton.render(canvas);
    }

    if (activeView == View.lost) {
      lost.render(canvas);
    }

    if (activeView == View.help) {
      helpView.render(canvas);
    }

    if (activeView == View.credits) {
      creditsView.render(canvas);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    for (var fly in flies) {
      fly.update(dt);
    }
    flies.removeWhere((Fly fly) => fly.isOffScreen);
    spawner.update(dt);
    if (isPlaying) {
      scoreDisplay.update(dt);
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    Offset offset = info.eventPosition.global.toOffset();
    // 音乐按钮
    if (musicButton.rect.contains(offset)) {
      musicButton.onTapDown();
      return;
    }

    // 音效按钮
    if (soundButton.rect.contains(offset)) {
      soundButton.onTapDown();
      return;
    }

    if (!isPlaying) {
      if (activeView != View.lost) {
        // 点击任意关闭弹窗
        activeView = View.home;
      }

      // 点击帮助按钮
      if (helpButton.rect.contains(offset)) {
        helpButton.onTapDown();
      }

      // 点击感谢按钮
      if (creditsButton.rect.contains(offset)) {
        creditsButton.onTapDown();
      }

      // 点击开始按钮
      if ((activeView == View.home || activeView == View.lost) &&
          startButton.rect.contains(offset)) {
        startButton.onTapDown();
      }
      return;
    }

    bool didHitAFly = false;
    for (var fly in flies) {
      if (fly.flyRect.contains(offset)) {
        fly.onTapDown(fly.value);
        didHitAFly = true;
      }
    }

    // 存活的飞蝇
    List<Fly> tmps = List<Fly>.empty(growable: true);
    for (var fly in flies) {
      if (!fly.isDead) {
        tmps.add(fly);
      }
    }
    if (!didHitAFly && tmps.isNotEmpty) {
      activeView = View.lost;
      if (soundButton.isEnabled) {
        FlameAudio.play('sfx/haha' + (rand.nextInt(5) + 1).toString() + '.mp3');
      }
      // playHomeBGM();
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void spawnFly() {
    // 随机生成出生位置
    double x = rand.nextDouble() * (screenSize.width - (tileSize * 1.35));
    double y = (rand.nextDouble() * (screenSize.height - (tileSize * 2.85))) +
        (tileSize * 1.5);
    // flies.add(Fly(this, x, y));
    // flies.add(HouseFly(this, x, y));

    // s随机生成飞蝇类型
    switch (rand.nextInt(5)) {
      case 0:
        flies.add(HouseFly(this, x, y));
        break;
      case 1:
        flies.add(DroolerFly(this, x, y));
        break;
      case 2:
        flies.add(AgileFly(this, x, y));
        break;
      case 3:
        flies.add(MachoFly(this, x, y));
        break;
      case 4:
        flies.add(HungryFly(this, x, y));
        break;
    }
  }

  void updateActiveView(View view) {
    activeView = view;
  }

  void updateScore(int val) {
    if (isPlaying) {
      score += val;
      if (score > (storage.getInt('highscore') ?? 0)) {
        storage.setInt('highscore', score);
        highscoreDisplay.update();
      }
    }
  }

  void resetData() {
    score = 0;
  }

  void playHomeBGM() async {
    // await playingBGM.pause();
    // await playingBGM.seek(Duration.zero);
    // await homeBGM.resume();
  }

  void playPlayingBGM() async {
    // await homeBGM.pause();
    // await homeBGM.seek(Duration.zero);
    // await playingBGM.resume();
  }
}
