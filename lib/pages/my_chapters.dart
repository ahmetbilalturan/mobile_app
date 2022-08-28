import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/models/models.dart';
import 'package:test_app/services/authservices.dart';

class MyChapters extends StatefulWidget {
  final Manga manga;
  const MyChapters({Key? key, required this.manga}) : super(key: key);

  @override
  State<MyChapters> createState() => _MyChaptersState();
}

class _MyChaptersState extends State<MyChapters> {
  List<Chapter> allchapters = [];
  OverlayEntry? entry;

  void getChapters(int mangaID) async {
    await AuthService().getchapters(mangaID).then((val) {
      setState(() {
        allchapters = val.map((json) => Chapter.fromJson(json)).toList();
        if (entry != null) {
          hideLoadingOverlay();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showLoadingOverlay());
    getChapters(widget.manga.id);
  }

  void showLoadingOverlay() {
    final overlay = Overlay.of(context)!;

    entry = OverlayEntry(
      builder: (context) => buildLoadingOverlay(),
    );

    overlay.insert(entry!);
  }

  void hideLoadingOverlay() {
    entry!.remove();
    entry = null;
  }

  Widget buildLoadingOverlay() => const Material(
        color: Colors.transparent,
        elevation: 8,
        child: Center(
          child: CircularProgressIndicator(
              color: Color.fromARGB(255, 163, 171, 192)),
        ),
      );

  Widget chapterList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: allchapters.length,
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
            child: Container(
              color: const Color.fromARGB(154, 42, 42, 42),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.all(8),
                        height: 75,
                        width: 100,
                        child: Image.network(
                          allchapters[index].chapterCoverUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            allchapters[index].title,
                            style: TextStyle(
                                shadows: ColorList.textShadows,
                                color: ColorList.textColor,
                                fontSize: 20,
                                fontFamily: 'DynaPuff'),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Bölüm ${allchapters[index].id}',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 59, 59, 59)),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            allchapters[index].chapterDate,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 59, 59, 59)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          /////Chapter ismini editleme ve yayınlanacak mı boolenaı
                        },
                        icon: Icon(
                          Icons.edit,
                          color: ColorList.iconColor,
                          shadows: ColorList.textShadows,
                          size: 22,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 19,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  '210',

                                  ///databaseden bölümü kaç kişi beğenmiş onun verisini çek
                                  style: TextStyle(
                                      fontFamily: 'DynaPuff',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ))
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorList.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 10),
            sliver: SliverAppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/addchapter', arguments: []);
                    },
                    icon: const Icon(Icons.add_circle_outline),
                  ),
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
          SliverToBoxAdapter(
            child: SizedBox(
              height: 400,
              child: Stack(
                children: [
                  Container(
                    color: Colors.black,
                    height: 400,
                    child: ShaderMask(
                      blendMode: BlendMode.dstIn,
                      shaderCallback: (rect) {
                        return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black,
                              Colors.transparent,
                            ],
                            stops: [
                              .35,
                              1,
                            ]).createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      child: Image.network(
                        widget.manga.bannerUrl,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                '619',
                                style: TextStyle(
                                    fontFamily: 'DynaPuff',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            //Manga editleme
                          },
                          icon: Icon(
                            Icons.edit,
                            color: ColorList.iconColor,
                            shadows: ColorList.textShadows,
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 8, 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.manga.genre,
                              style: TextStyle(
                                  shadows: ColorList.textShadows,
                                  color: Colors.blue,
                                  fontFamily: 'DynaPuff'),
                            ),
                            Text(
                              ' / ',
                              style: TextStyle(
                                  shadows: ColorList.textShadows,
                                  color: Colors.white,
                                  fontFamily: 'DynaPuff'),
                            ),
                            Text(
                              widget.manga.weeklyPublishDay,
                              style: TextStyle(
                                  shadows: ColorList.textShadows,
                                  color: Colors.green,
                                  fontFamily: 'DynaPuff'),
                            ),
                            Text(
                              ' / ',
                              style: TextStyle(
                                  shadows: ColorList.textShadows,
                                  color: Colors.white,
                                  fontFamily: 'DynaPuff'),
                            ),
                            Text(
                              widget.manga.artist,
                              style: TextStyle(
                                  shadows: ColorList.textShadows,
                                  color: Colors.amber,
                                  fontFamily: 'DynaPuff'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.manga.title,
                          style: TextStyle(
                            shadows: ColorList.textShadows,
                            fontFamily: 'DynaPuff',
                            color: Colors.purple,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.manga.plot,
                          style: TextStyle(
                              shadows: ColorList.textShadows,
                              color: Colors.grey,
                              fontFamily: 'DynaPuff'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          chapterList(),
        ],
      ),
    );
  }
}
