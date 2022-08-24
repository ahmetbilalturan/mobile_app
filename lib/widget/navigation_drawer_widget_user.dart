import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/pages/loading_page.dart';
import 'package:test_app/pages/login_page.dart';

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

          buildHeader(
              urlImage: LoginPage.profilepicture.toString(),
              name: LoginPage.username, //Database'den Çekilecek
              onClicked: () =>
                  selectedItem(context, 0)), //navigate profile page

          const SizedBox(height: 10),
          buildMenuItem(
              text: 'Anasayfa',
              icon: Icons.home,
              onClicked: () => selectedItem(context,
                  1)), //with int value selectedItem function resolve which pages it should go
          const SizedBox(height: 8),
          buildMenuItem(
              text: 'Favoriler',
              icon: Icons.favorite,
              onClicked: () => selectedItem(context, 2)),
          const SizedBox(height: 8),
          buildMenuItem(
              text: 'Abonelikler',
              icon: Icons.subscriptions,
              onClicked: () => selectedItem(context, 3)),
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
              text: 'Çıkış Yap',
              icon: Icons.logout,
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

  Widget buildHeader({
    required String urlImage,
    required String name,
    required VoidCallback onClicked,
  }) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        padding: padding.add(const EdgeInsets.symmetric(vertical: 20)),
        child: Row(
          children: [
            ClipOval(
              child: Container(
                color: Colors.black,
                width: 50,
                height: 50,
                child: Image.network(
                  urlImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              name,
              style: TextStyle(
                  shadows: ColorList.textShadows,
                  fontSize: 17,
                  color: ColorList.textColor,
                  fontFamily: 'DynaPuff',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    //check route if its same dont navigate!!!!!!
    switch (index) {
      case 0:
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/profile");
        break;
      case 1:
        //should check current route name to set these clickable or not
        if (LoadingPage.currentRoute != '/homepage') {
          Navigator.of(context).popAndPushNamed("/homepage"); //navigating pages
          LoadingPage.currentRoute = '/homepage';
        } else {
          Navigator.of(context).pop();
        }
        break;
      case 2:
        if (LoadingPage.currentRoute != '/favorites') {
          Navigator.of(context).popAndPushNamed("/favorites");
          LoadingPage.currentRoute = '/favorites';
        } else {
          Navigator.of(context).pop();
        }
        break;
      //add weekly populers
      case 3:
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/subscriptions");
        break;
      case 4:
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/weekly");
        break;
      case 5:
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/all");
        break;
      case 6:
        SharedPreferences.getInstance().then(
          (prefs) {
            prefs.setString('userName', '');
            prefs.setString('password', '');
          },
        );
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        LoadingPage.isLogined = false;
        Navigator.of(context).pushNamed("/homepage");
      /* case 4:
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/wbest");
        break; */
    }
  }
}
