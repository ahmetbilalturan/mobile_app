import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:test_app/colorlist.dart';
import 'dart:io';

import 'package:test_app/widgets/all_widgets.dart';

class MyGrid extends StatefulWidget {
  const MyGrid({Key? key}) : super(key: key);

  @override
  State<MyGrid> createState() => _MyGridState();
}

class _MyGridState extends State<MyGrid> {
  List<File> images = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorList.backgroundColor,
      drawer: const NavigationDrawerWidgetUser(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(onPressed: () {}, icon: Icon(Icons.add_box)),
              )
            ],
            iconTheme: IconThemeData(
              color: ColorList.iconColor,
              shadows: ColorList.textShadows,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              '',
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
          SliverList(
              delegate: SliverChildBuilderDelegate(childCount: 5,
                  (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Container(
                height: 200,
                color: const Color.fromARGB(154, 42, 42, 42),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.network(
                              'https://static.wikia.nocookie.net/spy-x-family9171/images/0/0e/Volume_1.png/revision/latest?cb=20200508212135'),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 5, 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text(
                                          'Title:',
                                          style: TextStyle(
                                              fontFamily: 'DynaPuff',
                                              fontWeight: FontWeight.bold,
                                              color: ColorList.textColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text(
                                          'Genre:',
                                          style: TextStyle(
                                              fontFamily: 'DynaPuff',
                                              color: ColorList.textColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text(
                                          'Status:',
                                          style: TextStyle(
                                              color: ColorList.textColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text(
                                          'Chapter Count:',
                                          style: TextStyle(
                                              color: ColorList.textColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text(
                                          'Publish Day:',
                                          style: TextStyle(
                                              color: ColorList.textColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 5, 5, 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text(
                                          'Cart',
                                          style: TextStyle(
                                              color: ColorList.textColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text(
                                          'Curt',
                                          style: TextStyle(
                                              color: ColorList.textColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text(
                                          'Zart',
                                          style: TextStyle(
                                              color: ColorList.textColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text(
                                          'Zirt',
                                          style: TextStyle(
                                              color: ColorList.textColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text(
                                          'Zort',
                                          style: TextStyle(
                                              color: ColorList.textColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /* IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            shadows: ColorList.textShadows,
                            color: ColorList.iconColor,
                          ),
                        ), */
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add_circle_outline,
                              shadows: ColorList.textShadows,
                              color: ColorList.iconColor,
                            )),
                      ],
                    ),
                  ],
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
