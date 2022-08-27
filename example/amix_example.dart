import 'dart:io';
import 'package:amix/amix.dart';

void main() async {
  serverAddress = "127.0.0.1"; //your Server Address
  serverPort = 8080; //your Server Port
  AmixSetUp exampleServer =
      AmixSetUp(serverRoute: AmixRouteExample()); //server SetUp
  await exampleServer.startMultiCoreServer(
      isolateCount: 10); //Start Server With 10 Isolates
}

class AmixRouteExample extends AmixRoute {
  @override
  void setEntryPoints() {
    //set entry ports
    routeController.createRoute(
      "/hi", //route =>> /hi
      onCall: (AmixRequest request) {
        //when this route called
        return AmixResponse(
          //response
          response: (response) async {
            try {
              response.write("hello world!!"); //write something
              await response.flush(); //flush response
              await response.close(); //close response
            } catch (e) {
              print(e);
            }
          },
        );
      },
    );
  }

  @override
  AmixResponse onPageNotFound() {
    //if page not found
    return AmixResponse(
      //response
      response: (HttpResponse response) async {
        response.statusCode = 404; //change status code
        response.write("Page Not Found 404"); //write something
        await response.flush(); //flush response
        await response.close(); //close response
      },
    );
  }

  @override
  void onEveryCall() {
    // on Every Request that comes inside your server this function will be called
    print("on Every Call"); //on Every Call
  }
}
