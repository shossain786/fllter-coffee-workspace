import 'package:filtercoffee/modules/error/screens/network_error_screen.dart';
import 'package:filtercoffee/modules/error/screens/page_error_screen.dart';
import 'package:filtercoffee/modules/signin/screens/signin_screen.dart';
import 'package:filtercoffee/modules/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class RouterClassSection {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case '/login-screen':
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => SignInScreen(
              arguments: args,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => SignInScreen(
            arguments: const {},
          ),
        );
      case '/network-error-screen':
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (context) => NetworkErrorScreen(
              arguments: args,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => NetworkErrorScreen(
            arguments: const {},
          ),
        );
      default:
        return _errorRoute(settings);
    }
  }

  static Route<dynamic> _errorRoute(RouteSettings settings) {
    var args = settings.arguments;
    if (args is Map<String, dynamic>) {
      return MaterialPageRoute(
        builder: (context) => PageErrorScreen(
          arguments: args,
        ),
      );
    }
    return MaterialPageRoute(
      builder: (context) => PageErrorScreen(
        arguments: const {},
      ),
    );
  }
}
