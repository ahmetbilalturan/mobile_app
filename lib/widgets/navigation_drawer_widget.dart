import 'package:flutter/material.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/widgets/all_widgets.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //its sidebar menu
    return Drawer(
      child: Container(
        color: ColorList.drawerBackgrounColor,
        child: ListView(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF16d8f3),
                    Color(0xFFe8ba66),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              height: 175,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                        child: Text(
                          'MANGOVER',
                          style: TextStyle(
                              shadows: ColorList.textShadows,
                              fontFamily: 'SilkScreen',
                              color: const Color.fromARGB(255, 63, 125, 146),
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 10, 15),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                width: 1.5,
                                color: Color.fromARGB(141, 78, 78, 78),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .popAndPushNamed('/login', arguments: []);
                            },
                            child: const Text(
                              'Giriş Yap',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 88, 94, 114),
                                fontFamily: 'SilkScreen',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 15, 15),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                width: 1.5,
                                color: Color.fromARGB(141, 78, 78, 78),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .popAndPushNamed('/login', arguments: []);
                              Navigator.of(context)
                                  .pushNamed('/signup', arguments: []);
                            },
                            child: const Text(
                              'Kayıt Ol',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 88, 94, 114),
                                fontFamily: 'SilkScreen',
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            MenuItems().buildMenuItem(
              text: 'Anasayfa',
              icon: Icons.home,
              onClicked: () => MenuItems().selectedItem(context, 1),
            ), //with int value selectedItem function resolve which pages it should go
            const SizedBox(height: 8),
            MenuItems().buildMenuItem(
              text: 'Haftalık Yayınlar',
              icon: Icons.calendar_month,
              onClicked: () => MenuItems().selectedItem(context, 4),
            ),
            const SizedBox(height: 8),
            MenuItems().buildMenuItem(
              text: 'Tüm Mangalar',
              icon: Icons.book_sharp,
              onClicked: () => MenuItems().selectedItem(context, 5),
            ),
            /* buildMenuItem(
              text: 'Haftalık En İyiler',
              icon: Icons.auto_graph,
              onClicked: () => selectedItem(context, 4)), */
            const SizedBox(height: 8),
            const Divider(color: Colors.white70),
            const SizedBox(height: 8),
            MenuItems().buildMenuItem(
              text: 'Ayarlar',
              icon: Icons.settings,
              onClicked: () => MenuItems().selectedItem(context, 7),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
