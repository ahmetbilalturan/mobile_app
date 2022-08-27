import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:test_app/colorlist.dart';

class MyChapters extends StatefulWidget {
  const MyChapters({Key? key}) : super(key: key);

  @override
  State<MyChapters> createState() => _MyChaptersState();
}

class _MyChaptersState extends State<MyChapters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorList.backgroundColor,
      body: CustomScrollView(slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 10),
          sliver: SliverAppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(onPressed: () {}, icon: Icon(Icons.add_box)),
              )
            ],
            iconTheme: IconThemeData(
              color: ColorList.iconColor,
              shadows: ColorList.textShadows,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'Bölümler',
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
          ),
        ),
      ]),
    );
  }
}
