import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'dart:convert';

class ContentScreen extends StatefulWidget {
  const ContentScreen({Key? key}) : super(key: key);

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late List<Map<String, dynamic>> contentPages;
  bool dataFetched = false;

  void getContent() async {
    final webscraper = WebScraper('https://manhuas.net/');
    String tempRoute =
        'manhua/swordmasters-youngest-son-manhwa/swordmasters-youngest-son-chapter-1/';
    if (await webscraper.loadWebPage(tempRoute)) {
      contentPages =
          webscraper.getElement('div.page-break.no-gaps > img', ['src']);
      setState(() {
        dataFetched = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getContent();
  }

  String link = ''; // pull base64 link from db
  Uint8List encoder(String body) {
    return base64Decode(body.split(',')[1]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bölüm 1'),
        centerTitle: true,
      ),
      body:
          /*ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.memory(encoder(link), fit: BoxFit.fitHeight),
    )*/

          dataFetched
              ? Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: contentPages.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          contentPages[index]['attributes']['src']
                              .toString()
                              .trim(),
                          fit: BoxFit.fitWidth,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;

                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      }),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
    );
  }
}