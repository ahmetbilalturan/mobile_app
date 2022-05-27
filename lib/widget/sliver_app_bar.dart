import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'all_widgets.dart';

class SliverHeader extends StatelessWidget {
  final String title;
  const SliverHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color.fromARGB(255, 144, 34, 26),
      title: Text(title,
          style: const TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: true,
      floating: true,
      pinned: false,
      snap: false,
      actions: const [
        SearchButton(), //pull userid and push search button
      ],
    );
  }
}
