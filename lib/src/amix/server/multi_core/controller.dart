import 'dart:isolate';
import 'package:amix/src/amix/server/requests/request.dart';
import 'package:amix/src/amix/server/responses/response.dart';

class MultiCoreController {
  ///create Isolate
  static Future<SendPort> createIsolate() async {
    //create a SendPort for Isolate
    SendPort? isolateSendPort;
    //create a ReceivePort Just for initializing for Isolate
    ReceivePort receivePort = ReceivePort();
    //listen for a sendPort
    receivePort.listen((message) {
      if (message is SendPort) {
        //initialize the SendPort of Isolate
        isolateSendPort = message;
        return;
      }
    });
    //create Isolate
    await Isolate.spawn(
      (SendPort port) async {
        //start with getting a SendPort =>>>
        //send port is our recieve port send port
        //==========================================
        //create new ReceivePort for Isolate
        //we want connection between our isolates
        ReceivePort isolateReceivePort = ReceivePort();

        //send our send port for outSide RecievePort
        port.send(isolateReceivePort.sendPort);

        //created Isolate Successfully
        print("[Amix] Isolate Created");

        //we wait for send ports from setUp Part of Server
        SendPort? outSidePort;
        await for (Object event in isolateReceivePort) {
          if (event is SendPort) {
            //initialize new SendPort From Setup Part of Server
            outSidePort = event;
          }
          //if event is a Request we are going to run that Request path Function
          //Inside Isolate
          if (event is AmixRequest) {
            //create the Result
            AmixResponse result;
            //find the Function of Path
            var pathFunction =
                event.route.routeController.route[event.uri.path];
            //if Function was null its a page Not Found and we are going
            //to Start Page Not Found Function from Route Controller
            if (pathFunction == null) {
              //start pageNotFound Function From Route Controller
              result = event.route.onPageNotFound();
            } else {
              //start Function From path and put the result
              //inside Amix Response
              result = pathFunction(event);
            }
            //send back the AmixResponse for Our OutSide Port
            outSidePort?.send(result);
          }
        }
      },
      //initial receive Port Send Port for isolate
      receivePort.sendPort,
    );
    //wait until we get the isolate SendPort
    while (isolateSendPort == null) {
      await Future.delayed(Duration(milliseconds: 250));
    }
    //remove the top Receive Port.
    //we don't need it any more
    receivePort.close();

    //return our isolateSendPort
    return isolateSendPort!;
  }
}
