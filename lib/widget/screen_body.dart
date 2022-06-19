import 'package:flutter/material.dart';
import 'package:test_app/model/manga.dart';

class ScreenBody extends StatelessWidget {
  List<Manga> mangalist = [];
  ScreenBody({Key? key, required this.mangalist}) : super(key: key);

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
          childCount: mangalist.length,
          (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 2)),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        color: const Color.fromARGB(255, 12, 12, 12),
                        height: 200,
                        width: 150,
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed("/content"),
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                  stops: [
                                    .45,
                                    1,
                                  ]).createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstIn,
                            child: Image.network(
                              mangalist[index].urlImage,
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
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
                          mangalist[index].title,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).popAndPushNamed(
                              '/genre',
                              arguments: mangalist[index].genre),
                          child: Text(
                            mangalist[index].genre,
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
