import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/models/manga.dart';
import 'package:test_app/pages/login_page.dart';
import 'package:test_app/services/authservices.dart';
import 'dart:io';

import 'package:test_app/widgets/all_widgets.dart';

class MyGrid extends StatefulWidget {
  const MyGrid({Key? key}) : super(key: key);

  @override
  State<MyGrid> createState() => _MyGridState();
}

class _MyGridState extends State<MyGrid> {
  List<File> images = [];
  List<Manga> allmangas = [];
  List<Manga> dummyMangas = [];
  OverlayEntry? entry;

  void getArtistsMangas(int artistID) async {
    await AuthService().getartistsmangas(artistID).then((val) {
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

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() {
        images.add(imageTemp);
      });
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to pick image: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Widget buildItem(File image) {
    return Card(
      key: ValueKey(image),
      child: Image.file(
        image,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buildText(String text, bool isBold) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'DynaPuff',
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: ColorList.textColor),
      ),
    );
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
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle_outline)),
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
              floating: false, //its
              pinned: false, //for
              snap: false, //floating
            ),
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate(childCount: dummyMangas.length,
                      (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: InkWell(
                onTap: () => Navigator.of(context)
                    .pushNamed('/mychapters', arguments: []),
                child: Container(
                  height: 150,
                  color: const Color.fromARGB(154, 42, 42, 42),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: 100,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Image.network(
                          dummyMangas[index].urlImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildText('Title: ', true),
                            buildText('Genre: ', true),
                            buildText('Status: ', true),
                            buildText('Chapter Count: ', true),
                            buildText('Publish Day: ', true),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildText(dummyMangas[index].title, false),
                            buildText(dummyMangas[index].genre, false),
                            buildText(dummyMangas[index].status, false),
                            buildText(
                                (dummyMangas[index].chaptercount).toString(),
                                false),
                            buildText(
                                dummyMangas[index].weeklyPublishDay, false),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }))
        ],

        /* ReorderableGridView.count(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          footer: [
            Card(
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: pickImage,
                ),
              ),
            ),
          ],
          onReorder: (oldIndex, newIndex) {
            setState(() {
              final element = images.removeAt(oldIndex);
              images.insert(newIndex, element);
            });
          },
          children: images.map((image) => buildItem(image)).toList(),
        ), */
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: ColorList.iconColor,
        shadows: ColorList.textShadows,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.remove),
            )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              onPressed: pickImage,
              icon: const Icon(Icons.add),
            )),
      ],
    );
  }
}
