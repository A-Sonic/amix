import 'dart:io';
import 'package:amix/amix.dart';

void main() async {
  serverAddress = "127.0.0.1";
  serverPort = 8080;
  AmixSetUp exampleServer = AmixSetUp(serverRoute: AmixRouteExample());
  await exampleServer.startMultiCoreServer(isolateCount: 10);
}

class AmixRouteExample extends AmixRoute {
  @override
  void setEntryPoints() {
    routeController.createRoute(
      "/hi",
      onCall: (AmixRequest request) {
        return AmixResponse(
          response: (response) async {
            try {
              response.write("hello world!!");
              await response.flush();
              await response.close();
            } catch (e) {
              print(e);
            }
          },
        );
      },
    );
    routeController.createRoute(
      "/hi2",
      onCall: (AmixRequest request) {
        return AmixResponse(
          response: (response) async {
            response.write("hello world2!!");
            await response.close();
          },
        );
      },
    );
  }

  @override
  AmixResponse onPageNotFound() {
    return AmixResponse(
      response: (HttpResponse response) async {
        response.statusCode = 404;
        response.write("Page Not Found 404");
        await response.flush();
        await response.close();
      },
    );
  }

  @override
  void onEveryCall() {
    print(
      "on Every Call to server this function will be called",
    );
  }
}
