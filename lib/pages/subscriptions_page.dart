import 'package:flutter/material.dart';
import 'package:test_app/widget/all_widgets.dart';
import 'package:test_app/widget/sliver_app_bar.dart';

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
        drawer: NavigationDrawerWidget(),
        body: CustomScrollView(
          slivers: [
            SliverHeader(title: "Abonelikler"),
            ScrollingBody(), //push int values for scrolling body
          ],
        ));
  }
}
