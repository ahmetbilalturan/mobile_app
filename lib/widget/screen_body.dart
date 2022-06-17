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
          maxCrossAxisExtent: 150,
          mainAxisSpacing: 10,
          crossAxisSpacing: 3,
          childAspectRatio: .55,
          mainAxisExtent: 200,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              color: Colors.blue,
              child: Stack(
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      'png/cover_page_2.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 15),
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      verticalDirection: VerticalDirection.down,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "mangaismi",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        InkWell(
                          onTap: () => {print('genre sayfasına gidildi')},
                          child: Text(
                            "genre",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          childCount: 20,
        ),
      ),
    );
  }
}
