import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/colorlist.dart';

class AddMangaChapterItems {
  Widget alertBoxButtons(
      BuildContext context, Color color, String text, Function() function) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: color),
      onPressed: () {
        Navigator.of(context).pop(false);
        function();
      },
      child: Text(text),
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

  Widget infoScreenTitles(String text) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'DynaPuff',
          fontWeight: FontWeight.bold,
          color: ColorList.iconColor,
          shadows: ColorList.textShadows,
          decoration: TextDecoration.underline,
          fontSize: 20),
    );
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      label: Text(
        labelText,
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
          color: Color.fromARGB(255, 45, 54, 91),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color.fromARGB(255, 62, 74, 122)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }

  BottomNavigationBar bottomNavigationBar(
      PageController pageController,
      int currentIndex,
      Function(int index) function,
      List<BottomNavigationBarItem> bottomnavbaritems) {
    return BottomNavigationBar(
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
      onTap: (index) => function(index),
      items: bottomnavbaritems,
    );
  }

  Widget textWithDefaultStyle(String text, bool isBold) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'DynaPuff',
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: ColorList.textColor,
          shadows: ColorList.textShadows,
          fontSize: 15),
    );
  }
}
