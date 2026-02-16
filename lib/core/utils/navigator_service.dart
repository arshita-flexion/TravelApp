import 'package:flutter/material.dart';
import 'package:codefest_travel_app/core/routes/app_routes.dart';

class NavigatorService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Pushes a named route onto the navigator stack with left slide transition
  static Future<dynamic> pushNamed(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState?.push(
      PageRouteBuilder(
        settings: RouteSettings(name: routeName, arguments: arguments),
        pageBuilder: (context, animation, secondaryAnimation) => AppRoutes.routes[routeName]!(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide from right to left
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  // Pops the top-most route off the navigator stack with right slide transition
  static void goBack({dynamic result}) {
    return navigatorKey.currentState?.pop(result);
  }

  // Pushes a named route and removes all the routes until the predicate returns true
  static Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    bool routePredicate = false,
    dynamic arguments,
  }) async {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      PageRouteBuilder(
        settings: RouteSettings(name: routeName, arguments: arguments),
        pageBuilder: (context, animation, secondaryAnimation) => AppRoutes.routes[routeName]!(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide from right to left
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
      (route) => routePredicate,
    );
  }

  // Pops the current route off the navigator stack and pushes a new named route
  static Future<dynamic> popAndPushNamed(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState?.popAndPushNamed(routeName, arguments: arguments);
  }

  // Replaces the old route with a new named route
  static Future<dynamic> replaceRoute(String oldRoute, String newRoute, {dynamic arguments}) async {
    navigatorKey.currentState?.removeRoute(ModalRoute.of(navigatorKey.currentState!.context)!);
    return navigatorKey.currentState?.pushReplacement(
      PageRouteBuilder(
        settings: RouteSettings(name: newRoute, arguments: arguments),
        pageBuilder: (context, animation, secondaryAnimation) => AppRoutes.routes[newRoute]!(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide from right to left
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  // Pops routes off the navigator stack until the specified route is reached
  static void popUntil(String routeName) {
    return navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }

  // Replaces the current route with a new named route
  static Future<dynamic> pushReplacement(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState?.pushReplacement(
      PageRouteBuilder(
        settings: RouteSettings(name: routeName, arguments: arguments),
        pageBuilder: (context, animation, secondaryAnimation) => AppRoutes.routes[routeName]!(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide from right to left
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  // Pops routes off the navigator stack until the predicate returns true and then pushes a new named route
  static Future<dynamic> pushAndRemoveUntil(String routeName, {bool routePredicate = false, dynamic arguments}) async {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      PageRouteBuilder(
        settings: RouteSettings(name: routeName, arguments: arguments),
        pageBuilder: (context, animation, secondaryAnimation) => AppRoutes.routes[routeName]!(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Slide from right to left
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
      (route) => routePredicate,
    );
  }
}
