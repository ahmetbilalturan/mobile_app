import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  const icon = Icons.notifications;

  return AppBar(
    //leading: BackButton(),
    elevation: 0,
    backgroundColor: Colors.transparent,
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(icon),
      ),
    ],
  );
}
