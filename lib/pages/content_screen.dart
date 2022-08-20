import 'package:flutter/material.dart';
import 'package:test_app/services/authservices.dart';

import '../colorlist.dart';
import '../model/chapter.dart';
import '../model/manga.dart';
import '../widget/sliver_app_bar.dart';
import 'manga_page.dart';

class ContentScreen extends StatefulWidget {
  final int chapterID, mangaID, indexofchapter;
  final String chapterName;
  final List<Chapter> allchapters;
  final Manga manga;
  const ContentScreen(
      {Key? key,
      required this.chapterID,
      required this.mangaID,
      required this.chapterName,
      required this.allchapters,
      required this.indexofchapter,
      required this.manga})
      : super(key: key);

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  List dummypages = [];
  List<String> pages = [];
  bool isEmpty = true;
  OverlayEntry? entry;

  void getPages() async {
    await AuthService()
        .getchapterpages(widget.mangaID, widget.chapterID)
        .then((val) {
      dummypages = val;

      for (int i = 0; i < dummypages.length; i++) {
        pages.add(dummypages[i].toString());
      }

      setState(() {
        if (pages.isEmpty) {
          isEmpty = true;
        } else {
          isEmpty = false;
        }
        hideLoadingOverlay();
      });
    });
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showLoadingOverlay());
    getPages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFd4fbcc),
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
            SliverList(
                delegate: SliverChildBuilderDelegate(childCount: pages.length,
                    (BuildContext context, int index) {
              return Image.network(
                pages[index],
                fit: BoxFit.fitWidth,
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
              );
            })),
            /* SliverToBoxAdapter(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: widget.indexofchapter > 0
                        ? ForwardBackButton(
                            widget: widget,
                            goto: -1,
                            icon: Icons.arrow_back_ios)
                        : null),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: widget.indexofchapter < widget.allchapters.length - 1
                      ? ForwardBackButton(
                          widget: widget,
                          goto: 1,
                          icon: Icons.arrow_forward_ios)
                      : null,
                )
              ]),
            ), */
          ],
        ),
      ),
    );
  }
}

class ForwardBackButton extends StatelessWidget {
  final ContentScreen widget;
  final int goto;
  final IconData icon;
  const ForwardBackButton(
      {Key? key, required this.widget, required this.goto, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color.fromARGB(38, 0, 0, 0)),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContentScreen(
              chapterID: widget.allchapters[widget.indexofchapter + goto].id,
              mangaID: widget.mangaID,
              indexofchapter: widget.indexofchapter + goto,
              allchapters: widget.allchapters,
              chapterName:
                  widget.allchapters[widget.indexofchapter + goto].title,
              manga: widget.manga,
            ),
          ),
        );
      },
      child: Icon(icon),
    );
  }
}
