import 'package:flutter/material.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/pages/loading_page.dart';

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
                            Navigator.of(context).popAndPushNamed('/login');
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
                            Navigator.of(context).popAndPushNamed('/login');
                            Navigator.of(context).pushNamed('/signup');
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
          buildMenuItem(
              text: 'Anasayfa',
              icon: Icons.home,
              onClicked: () => selectedItem(context,
                  1)), //with int value selectedItem function resolve which pages it should go
          const SizedBox(height: 8),
          buildMenuItem(
              text: 'Haftalık Yayınlar',
              icon: Icons.calendar_month,
              onClicked: () => selectedItem(context, 4)),
          const SizedBox(height: 8),
          buildMenuItem(
              text: 'Tüm Mangalar',
              icon: Icons.book_sharp,
              onClicked: () => selectedItem(context, 5)),
          /* buildMenuItem(
              text: 'Haftalık En İyiler',
              icon: Icons.auto_graph,
              onClicked: () => selectedItem(context, 4)), */
          const SizedBox(height: 8),
          const SizedBox(height: 8),
          const Divider(color: Colors.white70),
          const SizedBox(height: 8),
          const SizedBox(height: 8),
          buildMenuItem(
              text: 'Ayarlar',
              icon: Icons.settings,
              onClicked: () => selectedItem(context, 6)),
          const SizedBox(height: 24),
        ],
      ),
    ));
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: ColorList.iconColor,
        shadows: ColorList.textShadows,
      ),
      title: Text(
        text,
        style: TextStyle(
            shadows: ColorList.textShadows,
            color: ColorList.textColor,
            fontFamily: 'DynaPuff',
            fontWeight: FontWeight.bold),
      ),
      hoverColor: Colors.white70,
      onTap: onClicked,
    );
  }

  Widget buildHeader() {
    return Container();
  }

  void selectedItem(BuildContext context, int index) {
    //check route if its same dont navigate!!!!!!
    switch (index) {
      case 1:
        if (LoadingPage.currentRoute != '/homepage') {
          Navigator.of(context).popAndPushNamed("/homepage"); //navigating pages
          LoadingPage.currentRoute = '/homepage';
        } else {
          Navigator.of(context).pop();
        }
        break;
      case 4:
        if (LoadingPage.currentRoute != '/weekly') {
          Navigator.of(context).popAndPushNamed('/weekly');
          LoadingPage.currentRoute = '/weekly';
        } else {
          Navigator.of(context).pop();
        }
        break;
      case 5:
        if (LoadingPage.currentRoute != '/all') {
          Navigator.of(context).popAndPushNamed('/all');
          LoadingPage.currentRoute = '/all';
        } else {
          Navigator.of(context).pop();
        }
        break;
      /*  case 6:
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/login"); */
      /* case 4:
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/wbest");
        break; */
    }
  }
}
