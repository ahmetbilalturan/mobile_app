import 'package:archive/archive.dart';
import 'package:flutter/material.dart';

class InspectWebtoon extends StatefulWidget {
  const InspectWebtoon({Key? key}) : super(key: key);

  @override
  State<InspectWebtoon> createState() => _InspectWebtoonState();
}

class _InspectWebtoonState extends State<InspectWebtoon> {
  late String _dir;
  late List<String> _images, _tempImages;
  String _cbzPath = '';

  @override
  void initState() {
    super.initState();
    _images = List();
    _tempImages = List();
  }

  @override
  Widget build(BuildContext context) {}
}
