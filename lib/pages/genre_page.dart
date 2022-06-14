import 'package:flutter/material.dart';
import 'package:test_app/widget/all_widgets.dart';

class GenrePage extends StatefulWidget {
  final int userID;

  const GenrePage({Key? key, required this.userID}) : super(key: key);

  @override
  State<GenrePage> createState() => _GenrePage();
}

class _GenrePage extends State<GenrePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.purple,
      drawer: NavigationDrawerWidget(),
      body: CustomScrollView(
        slivers: [
          SliverHeader(title: "Tür İsmi"), //Database'den çekilecek
          ScreenBody(), //push int values for scrolling body
        ],
      ),
    );
  }
}
