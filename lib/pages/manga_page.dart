import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/model/chapter.dart';
import 'package:test_app/model/manga.dart';
import 'package:test_app/pages/login_page.dart';
import 'package:test_app/services/authservices.dart';
import 'package:test_app/widget/all_widgets.dart';

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
        .addtofavorites(LoginPage.username, widget.manga.id)
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
        .removefromfavorites(LoginPage.username, widget.manga.id)
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
        .checkifitsinfavorites(LoginPage.username, widget.manga.id)
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
    checkifitsinfavorites();
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
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          isitinfavorites
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                              (_) => showLoadingOverlay());
                                    });
                                    removefromfavorites();
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ))
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                              (_) => showLoadingOverlay());
                                    });
                                    addtofavorites();
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ),
                                ),
                        ],
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
