import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/foundation.dart';

void printLog(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}

Future<Sprite> loadSprite(String path) async {
  Image image = await Flame.images.load(path);
  return Sprite(image);
}
