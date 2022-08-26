Amix is a Package for creating Servers.

## Features

With this package, you can easily create your own servers.
This package automatically manages your isolates and you don't need to get involved with isolates.

## Getting started

Add the following to your pubspec.yaml file.

```yaml
dependencies:
  amix: ^0.0.1
```

Import the package.

```dart
import 'package:amix/amix.dart'
```

## Usage

```dart

import 'dart:io';
import 'package:amix/amix.dart';

void main() async {
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


```

## Additional information

