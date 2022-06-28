import 'package:flutter/material.dart';
import 'package:test_app/model/manga.dart';
import 'package:test_app/pages/screens.dart';
import 'package:test_app/services/authservices.dart';
import 'package:test_app/widget/all_widgets.dart';

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
        val.map((value) => {containers.add(value['collectionname'])}).toList();
        setState(() {});
        for (int i = 0; i < containers.length; i++) {
          ids.clear();
          mangatemp.clear();
          await AuthService()
              .gethomepagecontent(containers[i]
                  .toString()
                  .toLowerCase()
                  .replaceAll(RegExp(r"\s+\b|\b\s|\s|\b"), ""))
              .then((val) async {
            val.map((value) => {ids.add(value['mangaid'])}).toList();
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
    return Scaffold(
      backgroundColor: Colors.blue,
      drawer: const NavigationDrawerWidgetUser(), //push user id
      body: CustomScrollView(
        slivers: <Widget>[
          SliverHeader(title: widget.title),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: containers.length,
              (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  color: Colors.purple,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            ContainerName(
                              containerName:
                                  containers[index].toString(), //pull from db
                            ),
                            SeeAllButton(
                              seeallcontainerName:
                                  containers[index].toString(), //pull from db
                            ),
                          ],
                        ),
                        Container(
                          height: 216,
                          color: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: isFetched
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        mangas[index].length, //pull from db
                                    itemBuilder:
                                        (BuildContext context, int index2) {
                                      return Container(
                                        height: 200,
                                        width: 125,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: const Offset(0, 2)),
                                          ],
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Container(
                                                  color: const Color.fromARGB(
                                                      255, 12, 12, 12),
                                                  height: 200,
                                                  width: 150,
                                                  child: GestureDetector(
                                                    onTap: () => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MangaPage(
                                                                    manga: mangas[
                                                                            index]
                                                                        [
                                                                        index2]))),
                                                    child: ShaderMask(
                                                      shaderCallback: (rect) {
                                                        return const LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              Colors.black,
                                                              Colors
                                                                  .transparent,
                                                            ],
                                                            stops: [
                                                              .45,
                                                              1,
                                                            ]).createShader(
                                                            Rect.fromLTRB(
                                                                0,
                                                                0,
                                                                rect.width,
                                                                rect.height));
                                                      },
                                                      blendMode:
                                                          BlendMode.dstIn,
                                                      child: Image.network(
                                                        mangas[index][index2]
                                                            .urlImage,
                                                        fit: BoxFit.fill,
                                                        loadingBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Widget child,
                                                                ImageChunkEvent?
                                                                    loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          }
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              value: loadingProgress
                                                                          .expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                      loadingProgress
                                                                          .expectedTotalBytes!
                                                                  : null,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      color: (mangas[index]
                                                                      [index2]
                                                                  .status ==
                                                              'Yeni')
                                                          ? const Color.fromARGB(
                                                              201, 126, 10, 10)
                                                          : (mangas[index][
                                                                          index2]
                                                                      .status ==
                                                                  'Bitti')
                                                              ? const Color
                                                                      .fromARGB(
                                                                  190,
                                                                  13,
                                                                  44,
                                                                  106)
                                                              : const Color
                                                                      .fromARGB(
                                                                  174,
                                                                  17,
                                                                  134,
                                                                  21),
                                                      child: Text(
                                                        mangas[index][index2]
                                                            .status, //status (new, on going or end)
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Container(
                                                      color:
                                                          const Color.fromARGB(
                                                              196,
                                                              216,
                                                              198,
                                                              31),
                                                      child: Text(
                                                        mangas[index][index2]
                                                            .chaptercount
                                                            .toString(), //chapter count
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  10, 0, 10, 15),
                                              alignment: Alignment.bottomLeft,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                verticalDirection:
                                                    VerticalDirection.down,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    mangas[index][index2].title,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  InkWell(
                                                    onTap: () => Navigator.of(
                                                            context)
                                                        .popAndPushNamed(
                                                            '/genre',
                                                            arguments:
                                                                mangas[index]
                                                                        [index2]
                                                                    .genre),
                                                    child: Text(
                                                      mangas[index][index2]
                                                          .genre,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ),
                        )
                        //pull list from db
                      ],
                    ),

                    //add container(for exp: new releases) name from db and (see all) button!
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
