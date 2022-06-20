import 'package:flutter/material.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/model/chapter.dart';
import 'package:test_app/model/manga.dart';
import 'package:test_app/services/authservices.dart';
import 'package:test_app/widget/all_widgets.dart';

class MangaPage extends StatefulWidget {
  final Manga manga;
  const MangaPage({Key? key, required this.manga}) : super(key: key);

  @override
  State<MangaPage> createState() => _MangaPageState();
}

class _MangaPageState extends State<MangaPage> {
  List<Chapter> allchapters = [];

  void getChapters() async {
    await AuthService().getchapters(widget.manga.id).then((val) {
      setState(() {
        allchapters = val.map((json) => Chapter.fromJson(json)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFd4fbcc),
      drawer: const NavigationDrawerWidgetUser(),
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
          slivers: [
            const SliverPadding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              sliver: SliverHeader(title: ''),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(0),
              sliver: SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  height: 400,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 400,
                        child: Image.network(
                          'https://promo.com/tools/image-resizer/static/Pattern_image-8c050053eab884e51b8599607865d112.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.manga.genre,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  'day',
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.manga.artist,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.manga.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'mangakonusu mangakonusu mangakonusu mangakonusu mangakonusu mangakonusu mangakonusu mangakonusu mangakonusu',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
                delegate:
                    SliverChildBuilderDelegate(childCount: allchapters.length,
                        (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                child: InkWell(
                  onTap: () => Navigator.of(context).popAndPushNamed('/content',
                      arguments: allchapters[index].pages),
                  child: Container(
                    color: Color.fromARGB(255, 42, 42, 42),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                height: 75,
                                width: 100,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 75,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    allchapters[index].title,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Bölüm ${index + 1}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'date',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }))
          ],
        ),
      ),
    );
  }
}
