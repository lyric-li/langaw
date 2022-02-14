import 'package:flutter/foundation.dart';

void printLog(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}
