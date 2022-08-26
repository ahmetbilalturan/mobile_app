import 'package:flutter/material.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/pages/screens.dart';
import 'package:test_app/widgets/all_widgets.dart';

class NavigationDrawerWidgetUser extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawerWidgetUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //its sidebar menu
    return Drawer(
        child: Container(
      color: ColorList.drawerBackgrounColor,
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 15),

          MenuItems().buildHeader(
              padding: padding,
              urlImage: LoginPage.profilepicture.toString(),
              name: LoginPage.username, //Database'den Çekilecek
              onClicked: () =>
                  MenuItems().selectedItem(context, 0)), //navigate profile page

          const SizedBox(height: 10),
          MenuItems().buildMenuItem(
            text: 'Anasayfa',
            icon: Icons.home,
            onClicked: () => MenuItems().selectedItem(context, 1),
          ), //with int value selectedItem function resolve which pages it should go
          const SizedBox(height: 8),
          MenuItems().buildMenuItem(
              text: 'Favoriler',
              icon: Icons.favorite,
              onClicked: () => MenuItems().selectedItem(context, 2)),
          const SizedBox(height: 8),
          MenuItems().buildMenuItem(
              text: 'Abonelikler',
              icon: Icons.subscriptions,
              onClicked: () => MenuItems().selectedItem(context, 3)),
          const SizedBox(height: 8),
          MenuItems().buildMenuItem(
              text: 'Haftalık Yayınlar',
              icon: Icons.calendar_month,
              onClicked: () => MenuItems().selectedItem(context, 4)),
          const SizedBox(height: 8),
          MenuItems().buildMenuItem(
              text: 'Tüm Mangalar',
              icon: Icons.book_sharp,
              onClicked: () => MenuItems().selectedItem(context, 5)),
          const SizedBox(height: 8),
          LoginPage.isArtist
              ? MenuItems().buildMenuItem(
                  text: 'Çizer',
                  icon: Icons.draw,
                  onClicked: () => MenuItems().selectedItem(context, 7))
              : const SizedBox(),
          LoginPage.isArtist ? const SizedBox(height: 8) : const SizedBox(),
          const Divider(color: Colors.white70),
          const SizedBox(height: 8),
          MenuItems().buildMenuItem(
              text: 'Çıkış Yap',
              icon: Icons.logout,
              onClicked: () => MenuItems().selectedItem(context, 6)),
          const SizedBox(height: 24),
        ],
      ),
    ));
  }
}
