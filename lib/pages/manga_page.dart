import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/models/models.dart';
import 'package:test_app/pages/screens.dart';
import 'package:test_app/services/authservices.dart';
import 'package:test_app/widgets/all_widgets.dart';

class MangaPage extends StatefulWidget {
  final Manga manga;
  const MangaPage({Key? key, required this.manga}) : super(key: key);

  @override
  State<MangaPage> createState() => _MangaPageState();
}

class _MangaPageState extends State<MangaPage> {
  bool isitinfavorites = false;
  List<Chapter> allchapters = [];
  OverlayEntry? entry;

  void addtofavorites() async {
    await AuthService()
        .addtofavorites(LoginPage.userid, widget.manga.id)
        .then((val) {
      if (val.data['success']) {
        setState(() {
          hideLoadingOverlay();
          isitinfavorites = true;
        });
        Fluttertoast.showToast(
          msg: val.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        setState(() {
          hideLoadingOverlay();
        });
        Fluttertoast.showToast(
          msg: val.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }

  void removefromfavorites() async {
    await AuthService()
        .removefromfavorites(LoginPage.userid, widget.manga.id)
        .then((val) {
      if (val.data['success']) {
        setState(() {
          hideLoadingOverlay();
          isitinfavorites = false;
        });
        Fluttertoast.showToast(
          msg: val.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
  }

  void checkifitsinfavorites() async {
    await AuthService()
        .checkifitsinfavorites(LoginPage.userid, widget.manga.id)
        .then((val) {
      if (val.data['success']) {
        setState(() {
          isitinfavorites = true;
          if (entry != null) {
            hideLoadingOverlay();
          }
        });
      } else {
        setState(() {
          isitinfavorites = false;
          if (entry != null) {
            hideLoadingOverlay();
          }
        });
      }
    });
  }

  void getChapters() async {
    await AuthService().getchapters(widget.manga.id).then((val) {
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
    LoadingPage.isLogined ? checkifitsinfavorites() : null;
    getChapters();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFd4fbcc),
      body: Container(
        color: ColorList.backgroundColor,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              sliver: SliverHeader(title: widget.manga.title),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(0),
              sliver: SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
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
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
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
                      LoadingPage.isLogined
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                isitinfavorites
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) =>
                                                    showLoadingOverlay());
                                          });
                                          removefromfavorites();
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          shadows: ColorList.textShadows,
                                        ))
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) =>
                                                    showLoadingOverlay());
                                          });
                                          addtofavorites();
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          shadows: ColorList.textShadows,
                                        ),
                                      ),
                              ],
                            )
                          : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () => Navigator.of(context).pushNamed(
                                      '/genre',
                                      arguments: [widget.manga.genre]),
                                  child: Text(
                                    widget.manga.genre,
                                    style: TextStyle(
                                        shadows: ColorList.textShadows,
                                        color: Colors.blue,
                                        fontFamily: 'DynaPuff'),
                                  ),
                                ),
                                Text(
                                  ' / ',
                                  style: TextStyle(
                                      shadows: ColorList.textShadows,
                                      color: Colors.white,
                                      fontFamily: 'DynaPuff'),
                                ),
                                InkWell(
                                  onTap: () {
                                    LoadingPage.currentRoute = '/weekly';
                                    Navigator.of(context)
                                        .pushNamed('/weekly', arguments: [
                                      (widget.manga.weeklyPublishDay).toString()
                                    ]);
                                  },
                                  child: Text(
                                    widget.manga.weeklyPublishDay,
                                    style: TextStyle(
                                        shadows: ColorList.textShadows,
                                        color: Colors.green,
                                        fontFamily: 'DynaPuff'),
                                  ),
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
            ),
            SliverList(
                delegate:
                    SliverChildBuilderDelegate(childCount: allchapters.length,
                        (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                child: InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    '/contentpage',
                    arguments: [
                      allchapters[index].id,
                      widget.manga.id,
                      allchapters[index].title,
                      allchapters,
                      index,
                      widget.manga
                    ],
                  ),
                  child: Container(
                    color: const Color.fromARGB(154, 42, 42, 42),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            SizedBox(
                              height: 75,
                              child: Column(
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
                                    'Bölüm ${index + 1}',
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
