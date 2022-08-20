import 'package:flutter/material.dart';

class OnWillPop {
  final BuildContext context;

  const OnWillPop({
    required this.context,
  });

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Emin misin?'),
            content: const Text('Uygulamadan çıkmak istiyor musun?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Hayır'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Evet'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
