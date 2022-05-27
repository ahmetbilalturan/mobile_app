import 'package:flutter/material.dart';

class ScrollingBody extends StatelessWidget {
  const ScrollingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        //this handles vertical boxes.
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Container(
            color: index.isOdd ? Colors.white : Colors.black12,
            height: 250.0,
            //add container(for exp: new releases) name from db and (see all) button!

            child: ListView.builder(
              //This handles horizontal boxes.
              scrollDirection: Axis.horizontal,
              itemCount: 7, //pull from db!!!
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                  width: 150,
                  color: Colors
                      .red, //there should be cover photo, name and genres!
                );
              },
            ));
      },
      childCount: 10, //pull from db!
      //for favorites and subscriptions pages divide manga count with 3 if remaining value is over 0 add 1 to result
    ));
  }
}
