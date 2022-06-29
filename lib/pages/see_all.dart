import 'package:flutter/material.dart';
import 'package:test_app/widget/all_widgets.dart';

class SeeAllPage extends StatefulWidget {
  final int userID;
  final String title;

  const SeeAllPage({Key? key, required this.title, required this.userID})
      : super(key: key);

  @override
  State<SeeAllPage> createState() => _SeeAllPage();
}

class _SeeAllPage extends State<SeeAllPage> {
  int lenght = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      drawer: const NavigationDrawerWidgetUser(), //push user id
      body: CustomScrollView(
        slivers: <Widget>[
          SliverHeader(title: widget.title),
          /*  ScreenBody(
            lenght: lenght,
          ) */
        ],
        //push userid, list from db
      ),
    );
  }
}
