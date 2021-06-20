import 'package:flutter/material.dart';

import 'package:flame/flame.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './langaw-game.dart';

class Launch extends StatefulWidget {
  @override
  _LaunchState createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {

  int _progress = 0;

  @override
  void initState() {
    super.initState();
    initialize(this.context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage('assets/images/bg/backyard.png'),
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: 48.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color.fromRGBO(0, 0, 0, .45),
              ),
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                '正在加载数据...' + _progress.toString() + '%',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  height: 1.2,
                  decoration: TextDecoration.none,
                  decorationStyle: TextDecorationStyle.dashed,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void initialize(BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));
    updateProgress(10);

    // 加载图片资源
    await Flame.images.loadAll([
      'bg/backyard.png',
      'flies/agile-fly-1.png',
      'flies/agile-fly-2.png',
      'flies/agile-fly-dead.png',
      'flies/drooler-fly-1.png',
      'flies/drooler-fly-2.png',
      'flies/drooler-fly-dead.png',
      'flies/house-fly-1.png',
      'flies/house-fly-2.png',
      'flies/house-fly-dead.png',
      'flies/hungry-fly-1.png',
      'flies/hungry-fly-2.png',
      'flies/hungry-fly-dead.png',
      'flies/macho-fly-1.png',
      'flies/macho-fly-2.png',
      'flies/macho-fly-dead.png',
      'bg/lose-splash.png',
      'branding/title.png',
      'ui/dialog-credits.png',
      'ui/dialog-help.png',
      'ui/icon-credits.png',
      'ui/icon-help.png',
      'ui/start-button.png',
      'ui/callout.png',
      'ui/icon-music-disabled.png',
      'ui/icon-music-enabled.png',
      'ui/icon-sound-disabled.png',
      'ui/icon-sound-enabled.png',
    ]);

    await Future.delayed(Duration(seconds: 1));
    updateProgress(50);

    // 加载音频资源
    Flame.audio.disableLog();
    await Flame.audio.loadAll(<String>[
      'sfx/haha1.mp3',
      'sfx/haha2.mp3',
      'sfx/haha3.mp3',
      'sfx/haha4.mp3',
      'sfx/haha5.mp3',
      'sfx/ouch1.mp3',
      'sfx/ouch2.mp3',
      'sfx/ouch3.mp3',
      'sfx/ouch4.mp3',
      'sfx/ouch5.mp3',
      'sfx/ouch6.mp3',
      'sfx/ouch7.mp3',
      'sfx/ouch8.mp3',
      'sfx/ouch9.mp3',
      'sfx/ouch10.mp3',
      'sfx/ouch11.mp3',
      'bgm/playing.mp3',
      'bgm/home.mp3',
    ]);

    await Future.delayed(Duration(seconds: 1));
    updateProgress(98);

    // 初始化数据存储
    SharedPreferences storage = await SharedPreferences.getInstance();
    LangawGame game = LangawGame(storage);

    await Future.delayed(Duration(seconds: 1));
    updateProgress(100);

    print('数据加载完成, 进入游戏主界面');
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => game.widget,
    ));
  }

  void updateProgress(int value) {
    setState(() {
      _progress = value;
    });
    print(_progress);
  }
}
