import 'package:flutter/material.dart';
import 'package:test_app/pages/screens.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/homepage':
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Anasayfa'));
      case '/favorites':
        //check user id from db
        return MaterialPageRoute(
            builder: (context) => const FavoritesPage(userID: 13));
      case '/subscriptions':
        //check user id from db
        return MaterialPageRoute(
            builder: (context) => const SubscriptionsPage(userID: 13));
      case '/all':
        //check user id from db
        return MaterialPageRoute(
            builder: (context) => const AllMangasPage(userID: 13));

      default:
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Hata'));
    }
  }
}
