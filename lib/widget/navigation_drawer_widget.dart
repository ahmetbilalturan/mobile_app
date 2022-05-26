import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
      color: Colors.blue,
      child: ListView(
        padding: padding,
        children: <Widget>[
          const SizedBox(height: 48),
          buildMenuItem(text: 'Anasayfa', icon: Icons.home),
          const SizedBox(height: 8),
          buildMenuItem(
              text: 'Haftalık En Beğenilenler', icon: Icons.auto_graph),
          const SizedBox(height: 8),
          buildMenuItem(text: 'Favoriler', icon: Icons.favorite),
          const SizedBox(height: 8),
          buildMenuItem(text: 'Tüm Mangalar', icon: Icons.book),
          const SizedBox(height: 24),
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
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      hoverColor: Colors.white70,
      onTap: () {},
    );
  }
}
