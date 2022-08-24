import 'package:flutter/material.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/model/manga.dart';
import 'package:test_app/pages/loading_page.dart';
import 'package:test_app/pages/manga_page.dart';

// ignore: must_be_immutable
class ScrollingBody extends StatelessWidget {
  List<List<Manga>> mangas = [];
  List containers = [];
  bool isFetched = false;
  ScrollingBody(
      {Key? key,
      required this.mangas,
      required this.containers,
      required this.isFetched})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: containers.length,
        (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 0),
            padding: const EdgeInsets.symmetric(vertical: 2),
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
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: isFetched
                          ? ListView.builder(
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,
                              itemCount: mangas[index].length,
                              itemBuilder: (BuildContext context, int index2) {
                                return Container(
                                  height: 200,
                                  width: 125,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(.6),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                      )
                                    ],
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
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
                                                                  [index2]))),
                                              child: ShaderMask(
                                                shaderCallback: (rect) {
                                                  return const LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        Colors.black,
                                                        Colors.transparent,
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
                                                blendMode: BlendMode.dstIn,
                                                child: Image.network(
                                                  mangas[index][index2]
                                                      .urlImage,
                                                  fit: BoxFit.fill,
                                                  loadingBuilder:
                                                      (BuildContext context,
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
                                        borderRadius: BorderRadius.circular(5),
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                color: (mangas[index][index2]
                                                            .status ==
                                                        'Yeni')
                                                    ? const Color.fromARGB(
                                                        201, 126, 10, 10)
                                                    : (mangas[index][index2]
                                                                .status ==
                                                            'Bitti')
                                                        ? const Color.fromARGB(
                                                            190, 13, 44, 106)
                                                        : const Color.fromARGB(
                                                            174, 17, 134, 21),
                                                child: Text(
                                                  mangas[index][index2]
                                                      .status, //status (new, on going or end)
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Container(
                                                color: const Color.fromARGB(
                                                    196, 216, 198, 31),
                                                child: Text(
                                                  mangas[index][index2]
                                                      .chaptercount
                                                      .toString(), //chapter count
                                                  style: const TextStyle(
                                                      color: Colors.white),
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
                                              onTap: () => Navigator.of(context)
                                                  .popAndPushNamed('/genre',
                                                      arguments: mangas[index]
                                                              [index2]
                                                          .genre),
                                              child: Text(
                                                mangas[index][index2].genre,
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
    );
  }
}

class SeeAllButton extends StatelessWidget {
  final String seeallcontainerName;
  const SeeAllButton({Key? key, required this.seeallcontainerName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 15),
      ),
      onPressed: () {
        LoadingPage.currentRoute = '/seeall';
        Navigator.of(context)
            .pushNamed("/seeall", arguments: [seeallcontainerName]);
      }, //navigate to container page
      child: const Text('Tümünü Gör'),
    );
  }
}

class ContainerName extends StatelessWidget {
  final String containerName;
  const ContainerName({
    Key? key,
    required this.containerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        containerName,
        style: TextStyle(
          fontFamily: 'DynaPuff',
          shadows: ColorList.textShadows,
          fontSize: 17,
          color: ColorList.textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class WebtoonList extends StatelessWidget {
  const WebtoonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 251,
        color: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7, //pull from db
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Container(
                      margin: //add cover photo from db later
                          const EdgeInsets.symmetric(horizontal: 10.0),
                      height: 175,
                      width: 125,
                      child: GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed("/content"),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'png/cover_page_2.png',
                              fit: BoxFit.fill,
                            ),
                          ))),
                  const SizedBox(
                    height: 7,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed("/artist"),
                        child: const Text('Artist Name',
                            style: TextStyle(fontSize: 20, color: Colors.blue)),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed("/genre"),
                        child: const Text('Genre',
                            style: TextStyle(fontSize: 20, color: Colors.blue)),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ));
  }
}
