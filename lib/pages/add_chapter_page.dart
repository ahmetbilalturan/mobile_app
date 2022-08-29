import 'dart:async';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/pages/screens.dart';

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
  bool isGonnaPublish = false;
  String? title;
  TextEditingController titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? chapterCoverImage;
  List<Images> images = [];
  bool isRemoving = false;
  int currentIndex = 0;
  PageController pageController = PageController();
  List<BottomNavigationBarItem> bottomnavbaritems = const [
    BottomNavigationBarItem(
      label: 'Bölüm Bilgileri',
      icon: Icon(Icons.mode_edit),
      backgroundColor: Color.fromARGB(147, 9, 11, 19),
    ),
    BottomNavigationBarItem(
      label: 'Sayfa Ekle',
      icon: Icon(Icons.note_add),
      backgroundColor: Color.fromARGB(147, 9, 11, 19),
    ),
    BottomNavigationBarItem(
      label: 'Önizleme',
      icon: Icon(Icons.preview),
      backgroundColor: Color.fromARGB(147, 9, 11, 19),
    ),
  ];

  Future pickImage() async {
    try {
      ///Aynı anda birden fazla fotoğraf seçme ekle!!!!
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() {
        if (pageController.page == 0) {
          chapterCoverImage = imageTemp;
        } else if (pageController.page == 1) {
          images.add(Images(image: imageTemp, isSelected: false));
        }
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
        currentIndex == 1
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: isRemoving
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            for (var element in images) {
                              element.isSelected = false;
                            }
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
              )
            : const SizedBox(),
        currentIndex == 1
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: isRemoving
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            images.removeWhere(
                                (element) => element.isSelected == true);

                            isRemoving = false;
                          });
                        },
                        icon: const Icon(Icons.done),
                      )
                    : IconButton(
                        onPressed: pickImage,
                        icon: const Icon(Icons.add_circle_outline),
                      ),
              )
            : const SizedBox(),
        isRemoving
            ? const SizedBox()
            : currentIndex == bottomnavbaritems.length - 1
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Emin misin?'),
                            content: const Text(
                                'Bu bölümü yüklemek istediğine emin misin?'),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: ColorList.iconColor),
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text('Hayır'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 47, 125, 188)),
                                onPressed: () {
                                  if (title == null ||
                                      title == '' ||
                                      chapterCoverImage == null ||
                                      images.length < 10) {
                                    if (title == null || title == '') {
                                      showToast(
                                          'Başlık boş olamaz', Colors.red);
                                    }
                                    if (chapterCoverImage == null) {
                                      showToast(
                                          'Bölüm kapak fotoğrafı boş olamaz',
                                          Colors.red);
                                    }
                                    if (images.length < 10) {
                                      showToast(
                                          'Sayfa sayısı en az 10 olmalıdır',
                                          Colors.red);
                                    }
                                  } else {
                                    Navigator.of(context).pop(false);
                                    if (!isGonnaPublish) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title:
                                                    const Text('Emin misin?'),
                                                content: const Text(
                                                    'Oluşturduğunuz bölüm yayın sırasına alınmayacaktır!\n(Daha sonra ekleyebilirsiniz)'),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: const Color
                                                                    .fromARGB(
                                                                255,
                                                                47,
                                                                125,
                                                                188)),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: const Text('Hayır'),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: ColorList
                                                                .iconColor),
                                                    onPressed: () {
                                                      showToast(
                                                          'Bölüm başarıyla kaydedilmiştir',
                                                          Colors.green);
                                                      //api add chapter çağır
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: const Text('Evet'),
                                                  )
                                                ],
                                              ));
                                    } else {
                                      showToast(
                                          'Bölüm başarıyla kaydedilmiştir',
                                          Colors.green);

                                      ///api add chapter çağır
                                    }
                                  }
                                },
                                child: const Text('Evet'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.done),
                    ),
                  )
                : const SizedBox(),
      ],
    );
  }

  void showToast(String msg, Color color) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 26,
        selectedLabelStyle: TextStyle(
          fontFamily: 'DynaPuff',
          fontWeight: FontWeight.bold,
          shadows: ColorList.textShadows,
        ),
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(
            color: const Color.fromARGB(255, 207, 107, 107),
            shadows: ColorList.textShadows),
        unselectedIconTheme: IconThemeData(
            color: const Color.fromARGB(175, 207, 107, 107),
            shadows: ColorList.textShadows),
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 750),
            curve: Curves.ease,
          );
        }),
        items: bottomnavbaritems,
      ),
      backgroundColor: ColorList.backgroundColor,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          enterChapterInfo(),
          reorderableChapterPages(),
          previewPage()
        ],
      ),
    );
  }

  Widget enterChapterInfo() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Text(
                  'Bölüm Bilgileri',
                  style: TextStyle(
                      fontFamily: 'DynaPuff',
                      fontWeight: FontWeight.bold,
                      color: ColorList.iconColor,
                      shadows: ColorList.textShadows,
                      decoration: TextDecoration.underline,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7, bottom: 20, right: 22),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                            fontFamily: 'DynaPuff', color: ColorList.textColor),
                        onChanged: (value) {
                          setState(() {
                            title = value;
                          });
                        },
                        controller: titleController,
                        decoration: InputDecoration(
                          label: Text(
                            'Başlık',
                            style: TextStyle(
                                fontFamily: 'DynaPuff',
                                fontWeight: FontWeight.bold,
                                color: ColorList.textColor,
                                shadows: ColorList.textShadows,
                                fontSize: 15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                const BorderSide(color: Colors.lightBlue),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                const BorderSide(color: Colors.redAccent),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Text(
                              'Bölüm Kapağı:',
                              style: TextStyle(
                                  fontFamily: 'DynaPuff',
                                  fontWeight: FontWeight.bold,
                                  color: ColorList.textColor,
                                  shadows: ColorList.textShadows,
                                  fontSize: 15),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 32, 39, 66),
                                  side: const BorderSide(
                                    width: 1.5,
                                    color: Color.fromARGB(255, 55, 67, 116),
                                  ),
                                ),
                                onPressed: () {
                                  pickImage();
                                },
                                child: Text(
                                  chapterCoverImage == null
                                      ? 'Ekle'
                                      : 'Değiştir',
                                  style: TextStyle(
                                      fontFamily: 'DynaPuff',
                                      fontWeight: FontWeight.normal,
                                      color: ColorList.textColor,
                                      shadows: ColorList.textShadows,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                'Yayın Sırasına Ekle:',
                                style: TextStyle(
                                    fontFamily: 'DynaPuff',
                                    fontWeight: FontWeight.bold,
                                    color: ColorList.textColor,
                                    shadows: ColorList.textShadows,
                                    fontSize: 15),
                              ),
                            ),
                            Checkbox(
                                checkColor:
                                    const Color.fromARGB(255, 35, 102, 157),
                                fillColor: MaterialStateProperty.resolveWith(
                                    (states) =>
                                        const Color.fromARGB(255, 55, 67, 116)),
                                value: isGonnaPublish,
                                onChanged: (value) {
                                  setState(() {
                                    isGonnaPublish = value!;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Önizleme',
                style: TextStyle(
                    fontFamily: 'DynaPuff',
                    fontWeight: FontWeight.bold,
                    color: ColorList.iconColor,
                    shadows: ColorList.textShadows,
                    decoration: TextDecoration.underline,
                    fontSize: 20),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
          child: Container(
            color: const Color.fromARGB(154, 42, 42, 42),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(8),
                      height: 75,
                      width: 100,
                      child: chapterCoverImage == null
                          ? Center(
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  pickImage();
                                },
                                color: const Color.fromARGB(255, 109, 109, 109),
                              ),
                            )
                          : Image.file(
                              chapterCoverImage!,
                              fit: BoxFit.fill,
                            ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //değişken ekle
                          title == null || title == '' ? 'Başlık' : title!,
                          style: TextStyle(
                              shadows: ColorList.textShadows,
                              color: ColorList.textColor,
                              fontSize: 20,
                              fontFamily: 'DynaPuff'),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Bölüm No(Otomatik Verilir)',
                          style:
                              TextStyle(color: Color.fromARGB(255, 59, 59, 59)),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Tarih(Otomatik Verilir)',
                          style:
                              TextStyle(color: Color.fromARGB(255, 59, 59, 59)),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 19,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                '?',
                                style: TextStyle(
                                    fontFamily: 'DynaPuff',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ))
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget reorderableChapterPages() {
    return ReorderableGridView.count(
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
    );
  }

  Widget previewPage() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(top: 10),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: images.length,
              (BuildContext context, int index) {
                return Image.file(
                  images[index].image,
                  fit: BoxFit.fitWidth,
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
