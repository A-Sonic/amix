import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:amix/amix.dart';
import 'package:amix/src/amix/server/connection/server.dart';
import 'package:amix/src/amix/server/multi_core/multi_core.dart';

class AmixSetUpController {
  ///Starts server on 1 or more isolates
  ///
  ///on this Mode your server Depending on how many isolate you have
  ///can handle 1 or more requests at a time
  ///if server get Tomany requests at same time Depending on count of isolates
  ///server will work on some of them and reject others
  static Future start(
    int coreCount, {
    required AmixRoute route,
  }) async {
    //what isolate system will send the request on
    int isolateUseNow = 0;
    //isolates SendPorts
    final List<SendPort> isolatesSendPort = [];
    //listners for http request
    final List<StreamController> isolatesSendPortHttpControllers = [];
    //create isolates
    for (var i = 0; i < coreCount; i++) {
      isolatesSendPort.add(await MultiCore.createInstanceOnNewCore());
    }
    //for sendports inside our isolateList
    for (var sendPort in isolatesSendPort) {
      //create a receive port
      final ReceivePort receivePort = ReceivePort();
      //save http request for after work for responsing
      late HttpRequest serverRequest;
      //a listner for http Requests
      StreamController httpRequestListner = StreamController();
      // receive port created for getting messages from isolates
      receivePort.listen((message) {
        if (message is AmixResponse) {
          //if message is a amix response
          //runining message
          message.response(
            //send http request
            //for function
            serverRequest.response,
          );
        }
      });
      //listner for http request
      //and then save them inside response var
      httpRequestListner.stream.listen((event) {
        if (event is HttpRequest) {
          serverRequest = event;
        }
      });
      //adding the isolate inside isolates list
      isolatesSendPortHttpControllers.add(httpRequestListner);
      //run send port for isolate to save our send port for returning data
      sendPort.send(receivePort.sendPort);
    }
    //get HttpServer
    final HttpServer server = await AmixHttpServer.bind();

    //waiting For Requests
    await for (final request in server) {
      //get request hide Parameters
      Map<String, String> hideParams = (request.method != "GET")
          ? Uri(
              query: await utf8.decodeStream(request),
            ).queryParameters
          : {};
      //create a AmixRequest
      var req = AmixRequest(
        persistentConnection: request.persistentConnection,
        protocolVersion: request.protocolVersion,
        connectionInfo: request.connectionInfo,
        contentLength: request.contentLength,
        certificate: request.certificate,
        cookies: request.cookies,
        headers: request.headers,
        method: request.method,
        requestedUri: request.requestedUri,
        uri: request.uri,
        route: route,
        hideParams: hideParams,
      );

      //send the HttpRequest for listner to save HttpRequest
      isolatesSendPortHttpControllers[isolateUseNow].add(request);
      //send the AmixRequest for a isolate to calculate
      isolatesSendPort[isolateUseNow].send(req);

      //going for next isolate next time
      isolateUseNow++;
      if (isolateUseNow == coreCount) {
        isolateUseNow = 0;
      }
    }
  }
}
