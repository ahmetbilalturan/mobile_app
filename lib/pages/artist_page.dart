import 'package:flutter/material.dart';
import 'package:test_app/widget/all_widgets.dart';

class ArtistPage extends StatefulWidget {
  final int userID;

  const ArtistPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<ArtistPage> createState() => _ArtistPage();
}

class _ArtistPage extends State<ArtistPage> {
  int lenght = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      drawer: const NavigationDrawerWidget(),
      body: CustomScrollView(
        slivers: [
          const SliverHeader(title: "Çizer İsmi"), //Database'den çekilecek
          ScreenBody(lenght: lenght), //push int values for scrolling body
        ],
      ),
    );
  }
}
