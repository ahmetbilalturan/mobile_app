import 'package:flutter/material.dart';
import 'package:test_app/widgets/all_widgets.dart';

class WeeklyBestPage extends StatefulWidget {
  const WeeklyBestPage({Key? key}) : super(key: key);

  @override
  State<WeeklyBestPage> createState() => _WeeklyBestPage();
}

class _WeeklyBestPage extends State<WeeklyBestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      drawer: const NavigationDrawerWidgetUser(),
      body: CustomScrollView(
        slivers: [
          SliverHeader(title: "Haftalık En İyiler"),
          //ScrollingBody(), //push int values for scrolling body
        ],
      ),
    );
  }
}
