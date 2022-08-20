import 'package:flutter/material.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/model/manga.dart';
import 'package:test_app/pages/login_page.dart';
import 'package:test_app/widget/all_widgets.dart';
import 'package:test_app/services/authservices.dart';

import '../widget/on_will_pop.dart';

class FavoritesPage extends StatefulWidget {
  final int userID;

  const FavoritesPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPage();
}

class _FavoritesPage extends State<FavoritesPage> {
  OverlayEntry? entry;
  bool isEmpty = false;
  List mangasjson = [];
  List<Manga> allmangas = [];
  List ids = [];
  List<Manga> dummyMangas = [];
  String query = '';

  void getFavorites() async {
    await AuthService().getfavorites(LoginPage.userid).then((val) async {
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
    getFavorites();
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
    return WillPopScope(
      onWillPop: OnWillPop(context: context).onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFFd4fbcc),
        drawer: const NavigationDrawerWidgetUser(),
        appBar: isEmpty
            ? AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                actions: const [
                  SearchButton(), //pull userid and push search button
                ],
                title: const Text("Favoriler",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
              )
            : null,
        body: isEmpty
            ? Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: ColorList.colors,
                    stops: ColorList.stops,
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Favorileriniz Bulunmamakta",
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              )
            : Container(
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
                    const SliverHeader(title: "Favoriler"),
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
      ),
    );
  }
}
