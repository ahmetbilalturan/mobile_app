import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
      color: const Color.fromARGB(255, 158, 26, 26),
      child: ListView(
        padding: padding,
        children: <Widget>[
          const SizedBox(height: 48),
          buildMenuItem(
              text: 'Anasayfa',
              icon: Icons.home,
              onClicked: () => selectedItem(context, 0)),
          const SizedBox(height: 8),
          buildMenuItem(
              text: 'Haftalık En Beğenilenler', icon: Icons.auto_graph),
          const SizedBox(height: 8),
          buildMenuItem(
              text: 'Favoriler',
              icon: Icons.favorite,
              onClicked: () => selectedItem(context, 1)),
          const SizedBox(height: 8),
          buildMenuItem(text: 'Abonelikler', icon: Icons.calendar_month),
          const SizedBox(height: 8),
          buildMenuItem(text: 'Tüm Mangalar', icon: Icons.book),
          const SizedBox(height: 8),
          const Divider(color: Colors.white70),
          const SizedBox(height: 24),
          buildMenuItem(text: 'Profil', icon: Icons.face),
          const SizedBox(height: 8),
          buildMenuItem(text: 'Profil', icon: Icons.face),
          const SizedBox(height: 8),
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
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      hoverColor: Colors.white70,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    //check route if its same dont navigate
    switch (index) {
      case 0:
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/");
        break;
      case 1:
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed("/second");
        break;
    }
  }
}
