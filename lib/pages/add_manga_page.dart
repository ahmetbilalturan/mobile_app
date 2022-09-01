import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/pages/loading_page.dart';
import 'package:test_app/pages/login_page.dart';
import 'package:test_app/widgets/all_widgets.dart';

class AddMangaPage extends StatefulWidget {
  const AddMangaPage({Key? key}) : super(key: key);

  @override
  State<AddMangaPage> createState() => _AddMangaPageState();
}

class _AddMangaPageState extends State<AddMangaPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController plotController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isWeekly = false;
  File? mangaCoverImage;
  File? mangaBannerImage;
  String? title;
  String? plot;
  int currentIndex = 0;
  PageController pageController = PageController();
  String dropDownDayValue = 'Pazartesi';
  String dropDownGenreValue = 'Macera';

  var days = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar'
  ];

  var genres = [
    'Macera',
    'Aksiyon',
    'Romantik',
    'Hayattan Kesitler',
    'Okul Hayatı',
  ];

  List<BottomNavigationBarItem> bottomnavbaritems = const [
    BottomNavigationBarItem(
      label: 'Bölüm Bilgileri',
      icon: Icon(Icons.mode_edit),
      backgroundColor: Color.fromARGB(147, 9, 11, 19),
    ),
    BottomNavigationBarItem(
      label: 'Önizleme',
      icon: Icon(Icons.preview),
      backgroundColor: Color.fromARGB(147, 9, 11, 19),
    ),
  ];

  Future pickImage(int index) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState(() {
        switch (index) {
          case 0:
            mangaCoverImage = File(image.path);
            break;
          case 1:
            mangaBannerImage = File(image.path);
            break;
        }
      });
    } on PlatformException catch (e) {
      AddMangaChapterItems().showToast('Failed to pick image: $e', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      bottomNavigationBar: AddMangaChapterItems()
          .bottomNavigationBar(pageController, currentIndex, (index) {
        setState(() {
          currentIndex = index;
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 750),
            curve: Curves.ease,
          );
        });
      }, bottomnavbaritems),
      backgroundColor: ColorList.backgroundColor,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          enterMangaInfo(),
          previewMangaPage(),
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(
        'Manga Ekle',
        style: TextStyle(
          fontFamily: 'DynaPuff',
          fontWeight: FontWeight.bold,
          color: ColorList.textColor,
          shadows: ColorList.textShadows,
          fontSize: 23,
        ),
      ),
      iconTheme: IconThemeData(
        color: ColorList.iconColor,
        shadows: ColorList.textShadows,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget enterMangaInfo() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddMangaChapterItems().infoScreenTitles('Manga Bilgileri'),
              Padding(
                padding: const EdgeInsets.only(left: 7, top: 10, right: 22),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'DynaPuff',
                            color: ColorList.textColor,
                            fontSize: 13,
                          ),
                          onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                          },
                          controller: titleController,
                          decoration:
                              AddMangaChapterItems().inputDecoration('Başlık'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          maxLines: 5,
                          style: TextStyle(
                            fontFamily: 'DynaPuff',
                            color: ColorList.textColor,
                            fontSize: 13,
                          ),
                          onChanged: (value) {
                            setState(() {
                              plot = value;
                            });
                          },
                          controller: plotController,
                          decoration: AddMangaChapterItems()
                              .inputDecoration('Manga Konusu'),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Manga Kapağı:',
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                primary: ColorList.drawerBackgrounColor,
                                side: const BorderSide(
                                  width: 1.5,
                                  color: Color.fromARGB(255, 45, 54, 91),
                                ),
                              ),
                              onPressed: () {
                                pickImage(0);
                              },
                              child: Text(
                                mangaCoverImage == null ? 'Ekle' : 'Değiştir',
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
                      Row(
                        children: [
                          Text(
                            'Banner:',
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                primary: ColorList.drawerBackgrounColor,
                                side: const BorderSide(
                                  width: 1.5,
                                  color: Color.fromARGB(255, 45, 54, 91),
                                ),
                              ),
                              onPressed: () {
                                pickImage(1);
                              },
                              child: Text(
                                mangaCoverImage == null ? 'Ekle' : 'Değiştir',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AddMangaChapterItems()
                              .textWithDefaultStyle('Manga Türü:', true),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: ColorList.drawerBackgrounColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: DropdownButton(
                                underline: Container(),
                                dropdownColor: ColorList.drawerBackgrounColor,
                                borderRadius: BorderRadius.circular(10),
                                style: TextStyle(
                                  fontFamily: 'DynaPuff',
                                  color: ColorList.textColor,
                                  shadows: ColorList.textShadows,
                                ),
                                value: dropDownGenreValue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                iconEnabledColor: ColorList.iconColor,
                                items: genres.map((String genre) {
                                  return DropdownMenuItem(
                                      value: genre, child: Text(genre));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropDownGenreValue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AddMangaChapterItems()
                                .textWithDefaultStyle('Haftalık Mı?', true),
                            Checkbox(
                              checkColor:
                                  const Color.fromARGB(255, 35, 102, 157),
                              fillColor: MaterialStateProperty.resolveWith(
                                  (states) =>
                                      const Color.fromARGB(255, 55, 67, 116)),
                              value: isWeekly,
                              onChanged: (value) {
                                setState(() {
                                  isWeekly = value!;
                                });
                              },
                            ),
                            isWeekly
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: ColorList.drawerBackgrounColor,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: DropdownButton(
                                      underline: Container(),
                                      dropdownColor:
                                          ColorList.drawerBackgrounColor,
                                      borderRadius: BorderRadius.circular(10),
                                      style: TextStyle(
                                        fontFamily: 'DynaPuff',
                                        color: ColorList.textColor,
                                        shadows: ColorList.textShadows,
                                      ),
                                      value: dropDownDayValue,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      iconEnabledColor: ColorList.iconColor,
                                      items: days.map((String day) {
                                        return DropdownMenuItem(
                                            value: day, child: Text(day));
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropDownDayValue = newValue!;
                                        });
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                  child: AddMangaChapterItems().infoScreenTitles('Önizleme')),
              Container(
                height: 200,
                width: 120,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(1, 1),
                      spreadRadius: 2,
                      blurRadius: 5.15,
                    ),
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
                                  ]).createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstIn,
                            child: mangaCoverImage == null
                                ? InkWell(
                                    onTap: () => pickImage(0),
                                    child: const Center(
                                        child: Icon(
                                      Icons.add,
                                      color: Colors.grey,
                                    )),
                                  )
                                : Image.file(
                                    mangaCoverImage!,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: const Color.fromARGB(201, 126, 10, 10),
                              child: const Text(
                                'Yeni', //status (new, on going or end)
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              color: const Color.fromARGB(196, 216, 198, 31),
                              child: const Text(
                                '0', //chapter count
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
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
                            title == null ? 'Başlık' : title!,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            dropDownGenreValue,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget previewMangaPage() {
    return ListView(
      children: [
        SizedBox(
          height: 400,
          child: Stack(
            children: [
              Container(
                color: Colors.black,
                height: 400,
                child: ShaderMask(
                  blendMode: BlendMode.dstIn,
                  shaderCallback: (rect) {
                    return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.transparent,
                        ],
                        stops: [
                          .35,
                          1,
                        ]).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  child: mangaBannerImage == null
                      ? InkWell(
                          onTap: () => pickImage(1),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : Image.file(
                          mangaBannerImage!,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            '?',
                            style: TextStyle(
                                fontFamily: 'DynaPuff',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 8, 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          dropDownGenreValue,
                          style: TextStyle(
                              shadows: ColorList.textShadows,
                              color: Colors.blue,
                              fontFamily: 'DynaPuff'),
                        ),
                        isWeekly
                            ? Text(
                                ' / ',
                                style: TextStyle(
                                    shadows: ColorList.textShadows,
                                    color: Colors.white,
                                    fontFamily: 'DynaPuff'),
                              )
                            : const SizedBox(),
                        isWeekly
                            ? Text(
                                dropDownDayValue,
                                style: TextStyle(
                                    shadows: ColorList.textShadows,
                                    color: Colors.green,
                                    fontFamily: 'DynaPuff'),
                              )
                            : const SizedBox(),
                        Text(
                          ' / ',
                          style: TextStyle(
                              shadows: ColorList.textShadows,
                              color: Colors.white,
                              fontFamily: 'DynaPuff'),
                        ),
                        Text(
                          LoginPage.username,
                          style: TextStyle(
                              shadows: ColorList.textShadows,
                              color: Colors.amber,
                              fontFamily: 'DynaPuff'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title == null ? 'Başlık' : title!,
                      style: TextStyle(
                        shadows: ColorList.textShadows,
                        fontFamily: 'DynaPuff',
                        color: Colors.purple,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      plot == null ? 'Manga Konusu' : plot!,
                      style: TextStyle(
                          shadows: ColorList.textShadows,
                          color: Colors.grey,
                          fontFamily: 'DynaPuff'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
