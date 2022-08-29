import 'package:flutter/material.dart';
import 'package:test_app/pages/my_chapters.dart';
import 'package:test_app/pages/screens.dart';

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
        return CustomPageRoute(child: const FavoritesPage());
      //save favorites in db for each userID
      case '/subscriptions':
        //check user id from db
        return CustomPageRoute(child: const SubscriptionsPage());
      //save subscriptions in db for each userID
      case '/all':
        //check user id from db
        return CustomPageRoute(child: const AllMangasPage());
      case '/wbest':
        //check user id from db
        return CustomPageRoute(child: const WeeklyBestPage());
      case '/seeall':
        if (args.elementAt(0) is String) {
          return CustomPageRoute(
            child: SeeAllPage(title: args.elementAt(0)),
          );
        }
        return CustomPageRoute(child: const MyHomePage(title: 'Hata'));
      case '/login':
        return CustomPageRoute(child: const LoginPage());
      case '/signup':
        return CustomPageRoute(child: const SignUpPage());
      case '/forgotpassword':
        return CustomPageRoute(child: const ForgotPassword());
      case '/contentpage':
        return CustomPageRoute(
          child: ContentScreen(
            chapterID: args.elementAt(0),
            mangaID: args.elementAt(1),
            chapterName: args.elementAt(2),
            allchapters: args.elementAt(3),
            indexofchapter: args.elementAt(4),
            manga: args.elementAt(5),
          ),
        );
      case '/profile':
        return CustomPageRoute(
            child: const ProfilePage(title: 'Hoşgeldin Kullanıcı'));
      case '/genre':
        return CustomPageRoute(
            child: GenrePage(genre: args.elementAt(0).toString()));
      case '/artist':
        return CustomPageRoute(child: ArtistPage(artist: args.toString()));
      case '/weekly':
        return CustomPageRoute(
            child: WeeklyScreen(
                day: args.isEmpty ? '' : args.elementAt(0).toString()));
      case '/mangapage':
        return CustomPageRoute(
          child: MangaPage(
            manga: args.elementAt(0),
          ),
        );
      case '/artistmanagementpage':
        return CustomPageRoute(child: const ArtistManagementPage());
      case '/mychapters':
        return CustomPageRoute(child: MyChapters(manga: args.elementAt(0)));
      case '/addchapter':
        return CustomPageRoute(child: const AddChapterPage());
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
