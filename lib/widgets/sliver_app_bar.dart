import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/colorlist.dart';

class SliverHeader extends StatelessWidget {
  final String title;
  const SliverHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: ColorList.iconColor,
        shadows: ColorList.textShadows,
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: (TextStyle(
            fontFamily: 'DynaPuff',
            shadows: ColorList.textShadows,
            color: ColorList.textColor,
            fontSize: 28,
            fontWeight: FontWeight.bold)),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      centerTitle: true,
      floating: false, //its
      pinned: false, //for
      snap: false, //floating
    );
  }
}
