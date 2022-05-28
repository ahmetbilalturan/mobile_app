import 'package:flutter/material.dart';
import 'package:test_app/widget/all_widgets.dart';
import 'package:test_app/widget/sliver_app_bar.dart';

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
      drawer: const NavigationDrawerWidget(), //push user id
      body: CustomScrollView(
        slivers: <Widget>[
          SliverHeader(title: widget.title),
          /*ButtonBar(
            children: [
              ElevatedButton(
                onPressed: () => print("selam"),
                child: const Text("salam"),
              )
            ],
          )*/
          const ScrollingBody(), //push user id
        ],
      ),
    );
  }
}
