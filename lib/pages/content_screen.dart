import 'package:flutter/material.dart';

class ContentScreen extends StatefulWidget {
  final String pages;
  const ContentScreen({Key? key, required this.pages}) : super(key: key);

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  List<String> pages = [];

  void getPages() {
    pages = widget.pages.split(',');
  }

  @override
  void initState() {
    super.initState();
    getPages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bölüm 1'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate(childCount: pages.length,
                  (BuildContext context, int index) {
            return Image.network(
              pages[index],
              fit: BoxFit.fitWidth,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            );
          })),
        ],
      ),
    );
  }
}
