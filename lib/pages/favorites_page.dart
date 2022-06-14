import 'package:flutter/material.dart';
import 'package:test_app/pages/home_page.dart';
import 'package:test_app/widget/all_widgets.dart';

class FavoritesPage extends StatefulWidget {
  final int userID;

  const FavoritesPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPage();
}

class _FavoritesPage extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      drawer: NavigationDrawerWidgetUser(name: MyHomePage.username.toString()),
      body: const CustomScrollView(
        slivers: [
          SliverHeader(title: "Favoriler"),
          //push int values for scrolling body
          ScreenBody(),
        ],
      ),
    );
  }
}
