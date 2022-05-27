import 'package:flutter/material.dart';
import 'package:test_app/pages/screens.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Anasayfa'));
      case '/second':
        //check user id from db
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Favoriler'));

      default:
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Hata'));
    }
  }
}
