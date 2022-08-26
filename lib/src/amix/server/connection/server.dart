import 'dart:io';
import 'package:amix/src/amix/setup/set_up.dart';

///[AmixHttpServer]
///
///AmixHttpServer will handle making your [HttpServer]
class AmixHttpServer {
  AmixHttpServer();

  ///create [HttpServer] with [serverAddress] and [serverPort]
  static Future<HttpServer> bind() async {
    return await HttpServer.bind(serverAddress, serverPort);
  }
}
