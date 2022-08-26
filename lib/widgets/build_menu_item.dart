import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/colorlist.dart';
import 'package:test_app/pages/screens.dart';

class MenuItems {
  void drawerRouteFunc(BuildContext context, String routeName) {
    if (LoadingPage.currentRoute != routeName) {
      Navigator.of(context)
          .popAndPushNamed(routeName, arguments: []); //navigating pages
      LoadingPage.currentRoute = routeName;
    } else {
      Navigator.of(context).pop();
    }
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        drawerRouteFunc(context, '/profile');
        break;
      case 1:
        drawerRouteFunc(context, '/homepage');
        break;
      case 2:
        drawerRouteFunc(context, '/favorites');
        break;
      case 3:
        drawerRouteFunc(context, '/subscriptions');
        break;
      case 4:
        drawerRouteFunc(context, '/weekly');
        break;
      case 5:
        drawerRouteFunc(context, '/all');
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
        LoadingPage.currentRoute = '/homepage';
        Navigator.of(context).pushNamed("/homepage");
        break;
      case 7:
        drawerRouteFunc(context, '/artistmanagementpage');
        LoadingPage.currentRoute = '/homepage';
        break;
    }
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required VoidCallback onClicked,
    required EdgeInsets padding,
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
                /* child: Image.network(
                  urlImage,
                  fit: BoxFit.cover,
                ), */
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
}
