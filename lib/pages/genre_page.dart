import 'package:flutter/material.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/model/manga.dart';
import 'package:test_app/services/authservices.dart';
import 'package:test_app/widget/all_widgets.dart';

class GenrePage extends StatefulWidget {
  final String genre;
  final int userID;

  const GenrePage({Key? key, required this.userID, required this.genre})
      : super(key: key);

  @override
  State<GenrePage> createState() => _GenrePage();
}

class _GenrePage extends State<GenrePage> {
  OverlayEntry? entry;
  List<Manga> allmangas = [];
  List<Manga> dummyMangas = [];
  String query = '';

  void getGenre() async {
    await AuthService().getgenre(widget.genre).then((val) {
      setState(() {
        allmangas = val.map((json) => Manga.fromJson(json)).toList();
        dummyMangas = allmangas;
        hideLoadingOverlay();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showLoadingOverlay());
    getGenre();
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
      hintText: 'Manga',
      onChanged: searchManga,
    );
  }

  void searchManga(String query) {
    final dummyMangas = allmangas.where((manga) {
      final titleLower = manga.title.toLowerCase();

      final searchLower = query.toLowerCase();

      return titleLower.startsWith(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.dummyMangas = dummyMangas;
    });
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
            SliverHeader(title: widget.genre),
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
