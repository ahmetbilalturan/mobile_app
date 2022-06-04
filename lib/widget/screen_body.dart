import 'package:flutter/material.dart';

class ScreenBody extends StatelessWidget {
  const ScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 225,
          mainAxisSpacing: 10,
          crossAxisSpacing: 15,
          childAspectRatio: .55,
          mainAxisExtent: 350,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: GestureDetector(
                          onTap: () => print('basıldı'),
                          child: Image.asset(
                            'png/cover_page_2.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      //pull artist name and genre from db
                      children: [
                        GestureDetector(
                          onTap: () => print('artist sayfasına gidildi'),
                          child: const Text('artist name',
                              style: TextStyle(fontSize: 18)),
                        ),
                        const SizedBox(height: 2),
                        GestureDetector(
                          onTap: () => print('genre sayfasına gidildi'),
                          child: const Text('genre',
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    )
                  ],
                ));
          },
          childCount: 20,
        ),
      ),
    );
  }
}
