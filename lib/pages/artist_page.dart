import 'package:flutter/material.dart';
import 'package:test_app/widget/all_widgets.dart';

class ArtistPage extends StatefulWidget {
  final int userID;

  const ArtistPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<ArtistPage> createState() => _ArtistPage();
}

class _ArtistPage extends State<ArtistPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.purple,
      drawer: NavigationDrawerWidget(),
      body: CustomScrollView(
        slivers: [
          SliverHeader(title: "Çizer İsmi"), //Database'den çekilecek
          ScreenBody(), //push int values for scrolling body
        ],
      ),
    );
  }
}
