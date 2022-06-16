import 'package:flutter/material.dart';

class ScreenBody extends StatelessWidget {
  final int lenght;
  const ScreenBody({Key? key, required this.lenght}) : super(key: key);

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
          mainAxisExtent: 400,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed("/artist"),
                    child: Text('mangaismi', style: TextStyle(fontSize: 18)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: 300,
                        width: 200,
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed("/content"),
                          child: Image.asset(
                            'png/cover_page_2.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    //pull artist name and genre from db
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed("/artist"),
                        child: const Text('Artist Name',
                            style: TextStyle(fontSize: 18)),
                      ),
                      const SizedBox(height: 2),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed("/genre"),
                        child:
                            const Text('Genre', style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
          childCount: lenght,
        ),
      ),
    );
  }
}
