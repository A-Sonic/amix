import 'dart:io';

import 'package:amix/amix.dart';

void main() async {
  serverAddress = "127.0.0.1";
  serverPort = 8080;
  AmixSetUp test = AmixSetUp(serverRoute: ArmanRoute());
  await test.startMultiCoreServer(isolateCount: 2);
}

class ArmanRoute extends AmixRoute {
  @override
  void setEntryPoints() {
    routeController.createRoute(
      "/test",
      onCall: (AmixRequest request) {
        return AmixResponse(
          response: (response) async {
            try {
              response.write("test");
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
      "/test2",
      onCall: (AmixRequest request) {
        return AmixResponse(
          response: (response) async {
            response.write("test2");
            await response.flush();
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
}
