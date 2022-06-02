import 'package:flutter/material.dart';
import 'package:test_app/widget/all_widgets.dart';

class ScreenBody extends StatelessWidget {
  const ScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //this handles vertical boxes.

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 10,
        crossAxisSpacing: 25,
        childAspectRatio: .65,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
              color: Colors.purple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 225,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'png/cover_page_2.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    //pull artist name and genre from db

                    color: Colors.green,
                    child: const Text("artist and genre"),
                  )
                ],
              ));
        },
        childCount: 20,
      ),
    );
  }
}
