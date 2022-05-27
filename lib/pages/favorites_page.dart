import 'package:flutter/material.dart';
import 'package:test_app/widget/all_widgets.dart';
import 'package:test_app/widget/sliver_app_bar.dart';

class FavoritesPage extends StatefulWidget {
  final int userID;

  const FavoritesPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPage();
}

class _FavoritesPage extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        drawer: NavigationDrawerWidget(),
        body: CustomScrollView(
          slivers: [
            SliverHeader(title: "Favoriler"),
            ScrollingBody(), //push int values for scrolling body
          ],
        ));
  }
}
