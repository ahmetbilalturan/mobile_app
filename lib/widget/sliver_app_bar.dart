import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SliverHeader extends StatelessWidget {
  final String title;
  const SliverHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: const IconThemeData(color: Color.fromARGB(255, 249, 220, 237)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(title,
          style: const TextStyle(
              color: Color.fromARGB(255, 249, 220, 237),
              fontSize: 28,
              fontWeight: FontWeight.bold)),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: true,
      floating: false, //its
      pinned: false, //for
      snap: false, //floating
    );
  }
}
