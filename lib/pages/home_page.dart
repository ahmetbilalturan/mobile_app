import 'package:flutter/material.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/model/manga.dart';
import 'package:test_app/services/authservices.dart';
import 'package:test_app/widget/all_widgets.dart';

import '../widget/on_will_pop.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<Manga>> mangas = [];
  List<Manga> mangatemp = [];
  List containers = [];
  List mangasjson = [];
  bool isFetched = false;

  void gethomepage() async {
    List ids = [];
    await AuthService().gethomepage().then(
      (val) async {
        val.map((value) => {containers.add(value['collectionName'])}).toList();
        setState(() {});
        for (int i = 0; i < containers.length; i++) {
          ids.clear();
          mangatemp.clear();
          await AuthService()
              .gethomepagecontent(containers[i].toString())
              .then((val) async {
            ids = val;
            if (ids.isNotEmpty) {
              for (int j = 0; j < ids.length; j++) {
                await AuthService().getonefromallmangas(ids[j]).then((val) {
                  mangatemp.add(Manga.fromJson(val));
                });
              }
            }
            mangas.add(mangatemp);
            mangas[i] = List.from(mangatemp);
          });
          setState(() {});
        }
      },
    );
    setState(() {
      isFetched = true;
    });
  }

  @override
  void initState() {
    super.initState();
    gethomepage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: OnWillPop(context: context).onWillPop,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFFd4fbcc),
        drawer: const NavigationDrawerWidgetUser(), //push user id
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: ColorList.colors,
              stops: ColorList.stops,
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverHeader(title: widget.title),
              ScrollingBody(
                  mangas: mangas, containers: containers, isFetched: isFetched),
            ],
          ),
        ),
      ),
    );
  }
}
