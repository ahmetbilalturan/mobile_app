import 'package:flutter/material.dart';
import 'package:test_app/pages/profile_page.dart';
import 'package:test_app/pages/screens.dart';
import 'package:test_app/pages/weekly_best.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments; //pass argument as userID

    switch (settings.name) {
      //create new homepage for signed in users
      case '/homepage':
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(
                  title: 'Anasayfa', //pull from db
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
      case '/wbest':
        //check user id from db
        return MaterialPageRoute(
            builder: (context) => const WeeklyBestPage(userID: 13));
      case '/seeall':
        if (args is String) {
          return MaterialPageRoute(
            builder: (context) => SeeAllPage(
              userID: 13,
              title: args,
            ),
          );
        }
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(
                  title: 'Hata',
                ));
      case '/login':
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case '/signup':
        return MaterialPageRoute(builder: (context) => const SignUpPage());
      case '/forgotpassword':
        return MaterialPageRoute(builder: (context) => const ForgotPassword());
      case '/content':
        return MaterialPageRoute(builder: (context) => const ContentScreen());
      case '/profile':
        return MaterialPageRoute(
            builder: (context) => const ProfilePage(
                  title: 'Hoşgeldin Kullanıcı', //Database'den isim
                  userID: 13,
                ));
      default:
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(
                  title: 'Hata',
                ));
    }
  }
}
