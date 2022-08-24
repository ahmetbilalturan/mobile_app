import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/services/authservices.dart';
import 'package:test_app/widget/scroll_to_hide_widget.dart';
import '../model/chapter.dart';
import '../model/manga.dart';
import '../widget/sliver_app_bar.dart';

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
  late ScrollController _controller;
  StreamController<bool> streamController = StreamController<bool>();

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
    _controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => showLoadingOverlay());
    getPages();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        streamController.add(true);
      },
      child: Scaffold(
        bottomNavigationBar: ScrollToHideWidget(
            stream: streamController.stream,
            controller: _controller,
            child: Container(
              height: 56,
              color: ColorList.backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.indexofchapter > 0)
                    ForwardBackButton(
                        widget: widget, goto: -1, icon: Icons.arrow_back_ios),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                      icon: const Icon(Icons.home)),
                  if (widget.indexofchapter < widget.allchapters.length - 1)
                    ForwardBackButton(
                        widget: widget, goto: 1, icon: Icons.arrow_forward_ios),
                ],
              ),
            )),
        backgroundColor: Colors.black,
        body: CustomScrollView(
          controller: _controller,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              sliver: SliverHeader(title: widget.chapterName),
            ),
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
    return Padding(
      padding: !(widget.indexofchapter < widget.allchapters.length - 1 ||
              widget.indexofchapter > 0)
          ? const EdgeInsets.symmetric(horizontal: 10)
          : const EdgeInsets.symmetric(horizontal: 0),
      child: IconButton(
        color: Colors.white,
        icon: Icon(icon),
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
      ),
    );
  }
}
