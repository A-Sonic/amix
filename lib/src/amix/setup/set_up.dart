import 'dart:io';
import 'package:amix/src/amix/route/route.dart';
import 'package:amix/src/amix/setup/controller.dart';

///Server Address
String serverAddress = "127.0.0.1";

///Server Port
int serverPort = 9090;

///`[AmixSetUp]`
///
///A SetUp for your server befor setUp
///you can change your server address or your server port
class AmixSetUp<T extends AmixRoute> {
  ///Route of Your Server
  final AmixRoute serverRoute;

  ///`[AmixSetUp]`
  ///
  ///A SetUp for your server befor setUp
  ///you can change your server address or your server port
  const AmixSetUp({required this.serverRoute});

  ///Starts server on 1 isolate
  ///
  ///on this Mode your server can handle just 1 request at a time
  ///if server get 2 or more requests at same time server will work on 1 of them
  ///and reject others
  Future<void> startThisIsolate() async {
    await AmixSetUpController.start(1, route: serverRoute);
  }

  ///Starts server on 1 or more isolates
  ///
  ///on this Mode your server Depending on how many isolate you have
  ///can handle 1 or more requests at a time
  ///if server get Tomany requests at same time Depending on count of isolates
  ///server will work on some of them and reject others
  Future<void> startMultiCoreServer({
    int? isolateCount,
  }) async {
    int autoDetectCores = Platform.numberOfProcessors * 5;
    await AmixSetUpController.start(
      (isolateCount == null) ? autoDetectCores : isolateCount,
      route: serverRoute,
    );
  }
}
