import 'package:flutter/material.dart';
import 'package:test_app/pages/home_page.dart';
import 'package:test_app/pages/login_page.dart';
import 'package:test_app/widget/all_widgets.dart';

class SubscriptionsPage extends StatefulWidget {
  final int userID;

  const SubscriptionsPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<SubscriptionsPage> createState() => _SubscriptionsPage();
}

class _SubscriptionsPage extends State<SubscriptionsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.purple,
      drawer: NavigationDrawerWidgetUser(),
      body: const CustomScrollView(
        slivers: [
          SliverHeader(title: "Abonelikler"),
          ScreenBody(), //push int values for scrolling body
        ],
      ),
    );
  }
}
