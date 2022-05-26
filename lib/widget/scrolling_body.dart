import 'package:flutter/material.dart';

class ScrollingBody extends StatelessWidget {
  const ScrollingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Container(
          color: index.isOdd ? Colors.white : Colors.black12,
          height: 250.0,
          child: Center(
            child: Text(
              '$index',
              textScaleFactor: 5,
            ),
          ),
        );
      },
      childCount: 10,
    ));
  }
}
