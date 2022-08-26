import 'dart:isolate';

import 'package:amix/src/amix/server/multi_core/controller.dart';

///
///**```MultiCore```**
///
///
/// This Class will help you for Making [Isolate] and multiThreading
class MultiCore {
  ///
  ///**```MultiCore```**
  ///
  ///
  /// This Class will help you for Making [Isolate] and multiThreading
  MultiCore();

  ///
  ///[createInstanceOnNewCore] Makes a [Isolate] For You
  ///
  ///
  ///This will help you for Making [Isolate] and multiThreading
  static Future<SendPort> createInstanceOnNewCore() async =>
      MultiCoreController.createIsolate();
}
