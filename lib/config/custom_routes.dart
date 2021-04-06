import 'package:flutter/material.dart';
import 'package:flutter_instagram/screens/screens.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => const Scaffold());
        break;
      case ScreensSlash.routeName:
        return ScreensSlash.route();
        break;
      case LoginScreen.routeName:
        return LoginScreen.route();
        break;
      case NavScreen.routeName:
        return NavScreen.route();
        break;

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Alguma coisa deu errado!'),
        ),
      ),
    );
  }
}
