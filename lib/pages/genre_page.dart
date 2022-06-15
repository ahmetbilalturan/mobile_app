import 'package:flutter/material.dart';
import 'package:test_app/pages/home_page.dart';
import 'package:test_app/widget/all_widgets.dart';

class GenrePage extends StatefulWidget {
  final int userID;

  const GenrePage({Key? key, required this.userID}) : super(key: key);

  @override
  State<GenrePage> createState() => _GenrePage();
}

class _GenrePage extends State<GenrePage> {
  int lenght = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      drawer: const NavigationDrawerWidgetUser(),
      body: CustomScrollView(
        slivers: [
          SliverHeader(title: "Tür İsmi"), //Database'den çekilecek
          ScreenBody(lenght: lenght), //push int values for scrolling body
        ],
      ),
    );
  }
}
