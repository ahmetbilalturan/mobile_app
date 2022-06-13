import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  final icon = Icons.notifications;

  return AppBar(
    leading: BackButton(),
    elevation: 0,
    backgroundColor: Colors.transparent,
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(icon),
      ),
    ],
  );
}
