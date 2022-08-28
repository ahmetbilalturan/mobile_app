import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:test_app/colorlist.dart';

class AddChapterPage extends StatefulWidget {
  const AddChapterPage({Key? key}) : super(key: key);

  @override
  State<AddChapterPage> createState() => _AddChapterPageState();
}

class Images {
  File image;
  bool isSelected;
  Images({required this.image, required this.isSelected});
}

class _AddChapterPageState extends State<AddChapterPage> {
  List<Images> images = [];
  bool isRemoving = false;

  Future pickImage() async {
    try {
      ///Aynı anda birden fazla fotoğraf seçme ekle!!!!
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() {
        images.add(Images(image: imageTemp, isSelected: false));
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

  Widget buildItem(Images imageObject) {
    return InkWell(
      onTap: () {
        setState(() {
          if (isRemoving) {
            if (imageObject.isSelected) {
              imageObject.isSelected = false;
            } else {
              imageObject.isSelected = true;
            }
          }
        });
      },
      key: ValueKey(imageObject),
      child: Card(
        color: const Color.fromARGB(71, 42, 42, 42),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              imageObject.image,
              fit: BoxFit.fill,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageObject.isSelected
                    ? Container(
                        color: Colors.blue,
                        child: const Icon(Icons.done, color: Colors.white),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(
        'Bölüm Ekle',
        style: TextStyle(
            fontFamily: 'DynaPuff',
            fontWeight: FontWeight.bold,
            color: ColorList.textColor),
      ),
      iconTheme: IconThemeData(
        color: ColorList.iconColor,
        shadows: ColorList.textShadows,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: isRemoving
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      images.forEach(
                        (element) {
                          element.isSelected = false;
                        },
                      );
                      isRemoving = false;
                    });
                  },
                  icon: const Icon(Icons.close),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isRemoving = true;
                    });
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline,
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: isRemoving
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      images
                          .removeWhere((element) => element.isSelected == true);

                      isRemoving = false;
                    });
                  },
                  icon: const Icon(Icons.done),
                )
              : IconButton(
                  onPressed: pickImage,
                  icon: const Icon(Icons.add_circle_outline),
                ),
        ),
        isRemoving
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/chapteroverview', arguments: [images]);
                  },
                  icon: const Icon(Icons.preview),
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: ColorList.backgroundColor,
      body: ReorderableGridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        crossAxisCount: 2,
        childAspectRatio: 3 / 4.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 10,
        footer: [
          InkWell(
            onTap: pickImage,
            child: const Card(
              color: Color.fromARGB(71, 42, 42, 42),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Color.fromARGB(255, 130, 129, 129),
                ),
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
      ),
    );
  }
}

class ChapterOverview extends StatefulWidget {
  final List<Images> imageObjects;
  const ChapterOverview({Key? key, required this.imageObjects})
      : super(key: key);

  @override
  State<ChapterOverview> createState() => _ChapterOverviewState();
}

class _ChapterOverviewState extends State<ChapterOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorList.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(
                color: ColorList.iconColor, shadows: ColorList.textShadows),
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'Önizleme',
              style: TextStyle(
                fontFamily: 'DynaPuff',
                fontWeight: FontWeight.bold,
                color: ColorList.textColor,
                shadows: ColorList.textShadows,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_forward))
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: widget.imageObjects.length,
                (BuildContext context, int index) {
                  return Image.file(
                    widget.imageObjects[index].image,
                    fit: BoxFit.fitWidth,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
