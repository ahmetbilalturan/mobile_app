import 'package:flutter/material.dart';
import 'package:test_app/widget/all_widgets.dart';

class WeeklyBestPage extends StatefulWidget {
  final int userID;

  const WeeklyBestPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<WeeklyBestPage> createState() => _WeeklyBestPage();
}

class _WeeklyBestPage extends State<WeeklyBestPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.purple,
      drawer: NavigationDrawerWidget(),
      body: CustomScrollView(
        slivers: [
          SliverHeader(title: "Haftalık En İyiler"),
          ScrollingBody(), //push int values for scrolling body
        ],
      ),
    );
  }
}
