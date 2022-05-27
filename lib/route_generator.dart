import 'package:flutter/material.dart';
import 'package:test_app/pages/screens.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments; //pass argument as userID

    switch (settings.name) {
      //create new homepage for signed in users
      case '/homepage':
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(
                  title: 'Anasayfa',
                  userID: 13, //pull from db
                ));
      case '/favorites':
        //check user id from db
        return MaterialPageRoute(
            builder: (context) => const FavoritesPage(
                userID: 13)); //save favorites in db for each userID
      case '/subscriptions':
        //check user id from db
        return MaterialPageRoute(
            builder: (context) => const SubscriptionsPage(
                userID: 13)); //save subscriptions in db for each userID
      case '/all':
        //check user id from db
        return MaterialPageRoute(
            builder: (context) => const AllMangasPage(userID: 13));

      default:
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(
                  title: 'Hata',
                  userID: 13,
                ));
    }
  }
}
