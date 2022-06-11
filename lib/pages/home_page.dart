import 'package:flutter/material.dart';
import 'package:test_app/widget/all_widgets.dart';

class MyHomePage extends StatefulWidget {
  final int userID;
  final String title;

  const MyHomePage({Key? key, required this.title, required this.userID})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      drawer: const NavigationDrawerWidgetUser(), //push user id
      body: CustomScrollView(
        slivers: <Widget>[
          SliverHeader(title: widget.title),
          const ScrollingBody(), //push user id
        ],
      ),
    );
  }
}
