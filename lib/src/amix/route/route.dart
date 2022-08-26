import 'package:amix/src/amix/server/requests/request.dart';
import 'package:amix/src/amix/server/responses/response.dart';

///[AmixRoute]
///
///This Class is your Server Route
///
///for using [AmixRoute]:
///
///-  You have to make a new class and that class most extends **`AmixRoute`**
abstract class AmixRoute {
  ///[AmixRoute]
  ///
  ///This Class is your Server Route
  ///
  ///for using [AmixRoute]:
  ///
  ///-  You have to make a new class and that class most extends **`AmixRoute`**
  AmixRoute() {
    setEntryPoints();
  }

  ///[Route]
  ///
  ///route is a Controller for routes of your Server.
  ///
  final Route routeController = Route();

  /// you need to set your Routes inside [setEntryPoints]
  ///
  /// otherwise your route will not create
  ///
  /// Example:
  /// ```
  /// (){
  ///   routeController.createRoute(
  ///     "/example_route",
  ///     onCall:(AmixRequest request){
  ///       print(request.method)
  ///       return AmixResponse(
  ///         response:(HttpResponse response)async{
  ///           response.write("hi User");
  ///           await response.flush();
  ///           await response.close();
  ///         }
  ///       )
  ///     },
  ///   );
  /// }
  /// ```
  void setEntryPoints();

  /// if Page Was Not Found what to do?
  AmixResponse onPageNotFound();

  /// if you want to Do Something every time a
  /// request comes inside Server we have onEveryCall for you.
  void onEveryCall();
}

///[Route]
///
///route is a Controller for routes of your Server.
///
class Route {
  ///[Route]
  ///
  ///route is a Controller for routes of your Server.
  ///
  Route();

  ///This map is controlling your route.
  ///
  ///for every route you have we are going to add a =>
  ///String route name and Funtion of that route
  ///
  final Map<String, AmixResponse Function(AmixRequest)> _routes = {};

  ///this Function makes a new route for your project.
  ///
  ///need a Path and Function of that path
  ///
  ///Example:
  ///```
  ///   var routeController = Route();
  ///   routeController.createRoute(
  ///     "/example_route",
  ///     onCall:(AmixRequest request){
  ///       print(request.method)
  ///       return AmixResponse(
  ///         response:(HttpResponse response)async{
  ///           response.write("hi User");
  ///           await response.flush();
  ///           await response.close();
  ///         }
  ///       )
  ///     },
  ///   );
  ///```
  void createRoute(
    String path, {
    required AmixResponse Function(AmixRequest) onCall,
  }) {
    _routes[path] = onCall;
  }

  ///give you a Map of your Routes.
  Map<String, AmixResponse Function(AmixRequest)> get route => _routes;
}
