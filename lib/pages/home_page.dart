import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widget/navigation_drawer_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return const Scaffold(
      drawer: NavigationDrawerWidget(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              backgroundColor: Colors.red,
              title: Text('home', style: TextStyle(color: Colors.white)),
              systemOverlayStyle: SystemUiOverlayStyle.dark)
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
