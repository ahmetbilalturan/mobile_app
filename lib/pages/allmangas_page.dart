import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/model/manga.dart';
import 'package:test_app/services/authservices.dart';
import 'package:test_app/widget/all_widgets.dart';

class AllMangasPage extends StatefulWidget {
  final int userID;

  const AllMangasPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<AllMangasPage> createState() => _AllMangasPage();
}

class _AllMangasPage extends State<AllMangasPage> {
  OverlayEntry? entry;
  List<Manga> allmangas = [];
  List<Manga> dummyMangas = [];
  String query = '';

  void getAllMangas() async {
    await AuthService().getallmangas().then((val) {
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
    getAllMangas();
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
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.purple,
      drawer: const NavigationDrawerWidgetUser(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFe699cb),
              Color(0xFFf3ccfb),
              Color(0xFFdce2f3),
              Color(0xFFd4fbcc),
              Color(0xFF73df99),
            ],
            stops: [
              0.03,
              0.25,
              0.5,
              0.85,
              1.6,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            const SliverHeader(title: 'Tüm Mangalar'),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              sliver: SliverToBoxAdapter(
                child: buildSearch(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 3,
                  childAspectRatio: .55,
                  mainAxisExtent: 200,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: dummyMangas.length,
                  (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 2)),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                color: const Color.fromARGB(255, 12, 12, 12),
                                height: 200,
                                width: 150,
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed("/content"),
                                  child: ShaderMask(
                                    shaderCallback: (rect) {
                                      return const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.black,
                                            Colors.transparent,
                                          ],
                                          stops: [
                                            .45,
                                            1,
                                          ]).createShader(Rect.fromLTRB(
                                          0, 0, rect.width, rect.height));
                                    },
                                    blendMode: BlendMode.dstIn,
                                    child: Image.network(
                                      dummyMangas[index].urlImage,
                                      fit: BoxFit.fill,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
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
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 15),
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              verticalDirection: VerticalDirection.down,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dummyMangas[index].title,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                InkWell(
                                  onTap: () =>
                                      {print('genre sayfasına gidildi')},
                                  child: Text(
                                    dummyMangas[index].genre,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
