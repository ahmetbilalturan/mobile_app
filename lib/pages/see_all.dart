import 'package:flutter/material.dart';
import 'package:test_app/widget/all_widgets.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/model/models.dart';
import 'package:test_app/services/authservices.dart';

class SeeAllPage extends StatefulWidget {
  final String title;

  const SeeAllPage({Key? key, required this.title}) : super(key: key);

  @override
  State<SeeAllPage> createState() => _SeeAllPage();
}

class _SeeAllPage extends State<SeeAllPage> {
  OverlayEntry? entry;
  bool isEmpty = false;
  List mangasjson = [];
  List<Manga> allmangas = [];
  List ids = [];
  List<Manga> dummyMangas = [];
  String query = '';

  void getContent() async {
    await AuthService().gethomepagecontent(widget.title).then((val) async {
      ids = val;
      for (int i = 0; i < ids.length; i++) {
        await AuthService().getonefromallmangas(ids[i]).then((val) {
          mangasjson.add(val);
        });
      }
      setState(() {
        allmangas = mangasjson.map((json) => Manga.fromJson(json)).toList();
        dummyMangas = allmangas;
        if (allmangas.isEmpty) {
          isEmpty = true;
        } else {
          isEmpty = false;
        }
        hideLoadingOverlay();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showLoadingOverlay());
    getContent();
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

  Widget buildSearch() {
    return SearchWidget(
      text: query,
      hintText: 'Manga or Genre',
      onChanged: searchManga,
    );
  }

  void searchManga(String query) {
    final dummyMangas = allmangas.where((manga) {
      final titleLower = manga.title.toLowerCase();
      final genreLower = manga.genre.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.startsWith(searchLower) ||
          genreLower.startsWith(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.dummyMangas = dummyMangas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFd4fbcc),
      appBar: isEmpty
          ? AppBar(
              iconTheme: IconThemeData(
                color: ColorList.iconColor,
                shadows: ColorList.textShadows,
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(widget.title,
                  style: TextStyle(
                      shadows: ColorList.textShadows,
                      color: ColorList.textColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
            )
          : null,
      body: Container(
        color: ColorList.backgroundColor,
        child: isEmpty
            ? const Center(
                child: Text(
                  "Bu Liste Boştur",
                  style: TextStyle(fontSize: 26),
                ),
              )
            : CustomScrollView(
                slivers: [
                  SliverHeader(title: widget.title),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    sliver: SliverToBoxAdapter(
                      child: buildSearch(),
                    ),
                  ),
                  ScreenBody(mangalist: dummyMangas),
                ],
              ),
      ),
    );
  }
}
