import 'package:flutter/material.dart';
import 'package:test_app/pages/artist_page.dart';
import 'package:test_app/pages/genre_page.dart';
import 'package:test_app/pages/profile_page.dart';
import 'package:test_app/pages/screens.dart';
import 'package:test_app/pages/weekly_best.dart';
import 'package:test_app/pages/weekly_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final List<dynamic> args =
        settings.arguments as List<dynamic>; //pass argument as userID

    switch (settings.name) {
      //create new homepage for signed in users
      case '/homepage':
        return CustomPageRoute(
            child: const MyHomePage(title: 'Anasayfa')); //pull from db
      case '/favorites':
        //check user id from db
        return CustomPageRoute(child: const FavoritesPage(userID: 13));
      //save favorites in db for each userID
      case '/subscriptions':
        //check user id from db
        return CustomPageRoute(child: const SubscriptionsPage(userID: 13));
      //save subscriptions in db for each userID
      case '/all':
        //check user id from db
        return CustomPageRoute(child: const AllMangasPage(userID: 13));
      case '/wbest':
        //check user id from db
        return CustomPageRoute(child: const WeeklyBestPage(userID: 13));
      case '/seeall':
        if (args.elementAt(0) is String) {
          return CustomPageRoute(
            child: SeeAllPage(userID: 12, title: args.elementAt(0)),
          );
        }
        return CustomPageRoute(child: const MyHomePage(title: 'Hata'));
      case '/login':
        return CustomPageRoute(child: const LoginPage());
      case '/signup':
        return CustomPageRoute(child: const SignUpPage());
      case '/forgotpassword':
        return CustomPageRoute(child: const ForgotPassword());
      /* case '/content':
        return MaterialPageRoute(
            builder: (context) => ContentScreen(
                  pages: args,
                )); */
      case '/profile':
        return CustomPageRoute(
            child: const ProfilePage(title: 'Hoşgeldin Kullanıcı', userID: 13));
      case '/genre':
        return CustomPageRoute(
            child: GenrePage(userID: 13, genre: args.toString()));
      case '/artist':
        return CustomPageRoute(
            child: ArtistPage(userID: 13, artist: args.toString()));
      case '/weekly':
        return CustomPageRoute(child: WeeklyScreen(day: args.toString()));
      /* case '/mangapage':
        return MaterialPageRoute(
            builder: ((context) => MangaPage(
                  manga: args.toString(),
                ))); */
      default:
        return MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Hata'));
    }
  }
}

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;

  CustomPageRoute({
    required this.child,
  }) : super(
          transitionDuration: const Duration(seconds: 0),
          pageBuilder: (context, animtation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
}
