import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/models/models.dart';
import 'package:test_app/pages/screens.dart';
import 'package:test_app/services/authservices.dart';
import 'dart:io';
import 'package:test_app/widgets/all_widgets.dart';

class ArtistManagementPage extends StatefulWidget {
  const ArtistManagementPage({Key? key}) : super(key: key);

  @override
  State<ArtistManagementPage> createState() => _ArtistManagementPageState();
}

class _ArtistManagementPageState extends State<ArtistManagementPage> {
  List<Manga> allmangas = [];
  List<Manga> dummyMangas = [];
  OverlayEntry? entry;

  void getArtistsMangas(int artistID) async {
    await AuthService().getartistsmangas(artistID).then((val) {
      setState(() {
        allmangas = val.map((json) => Manga.fromJson(json)).toList();
        dummyMangas = allmangas;
      });
    });
    setState(() {
      hideLoadingOverlay();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showLoadingOverlay());
    getArtistsMangas(LoginPage.userid);
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

  Widget buildText(String text, bool isBold) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'DynaPuff',
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: ColorList.textColor,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'DynaPuff',
          fontWeight: FontWeight.bold,
          color: ColorList.iconColor,
          fontSize: 15,
        ),
      ),
    );
  }

  void addMangaControl() {
    bool gotOnGoing = false;
    for (int index = 0; index < allmangas.length; index++) {
      if (allmangas[index].status == 'Devam Etmekte' ||
          allmangas[index].status == 'Yeni') {
        gotOnGoing = true;
      }
    }
    if (gotOnGoing) {
      Fluttertoast.showToast(
          msg: 'Hali hazırda devam eden manganız bulunmakta!',
          backgroundColor: Colors.red);
    } else {
      //Manga ekleme ekranına götür!
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorList.backgroundColor,
      drawer: const NavigationDrawerWidgetUser(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 10),
            sliver: SliverAppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: addMangaControl,
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
                'Mangalarım',
                style: (TextStyle(
                    fontFamily: 'DynaPuff',
                    shadows: ColorList.textShadows,
                    color: ColorList.textColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
              ),
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: dummyMangas.length,
              (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pushNamed('/mychapters',
                        arguments: [dummyMangas[index]]),
                    child: Container(
                      height: 175,
                      color: const Color.fromARGB(154, 42, 42, 42),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: 175,
                            width: 125,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: Image.network(
                              dummyMangas[index].urlImage,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 0),
                                  child: buildTitle(dummyMangas[index].title),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 5, 5),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          buildText('Tür: ', true),
                                          buildText('Durum: ', true),
                                          buildText('Bölüm Sayısı: ', true),
                                          buildText('Yayın Günü: ', true),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 5, 5),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          buildText(
                                              dummyMangas[index].genre, false),
                                          buildText(
                                              dummyMangas[index].status, false),
                                          buildText(
                                              (dummyMangas[index].chaptercount)
                                                  .toString(),
                                              false),
                                          buildText(
                                              dummyMangas[index]
                                                  .weeklyPublishDay,
                                              false),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
