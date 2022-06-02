import 'package:flutter/material.dart';
import 'package:test_app/widget/all_widgets.dart';

class AllMangasPage extends StatefulWidget {
  final int userID;

  const AllMangasPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<AllMangasPage> createState() => _AllMangasPage();
}

class _AllMangasPage extends State<AllMangasPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.purple,
      drawer: NavigationDrawerWidget(),
      body: CustomScrollView(
        slivers: [
          SliverHeader(title: "Tüm Mangalar"),
          ScreenBody(), //push int values for scrolling body
        ],
      ),
    );
  }
}
