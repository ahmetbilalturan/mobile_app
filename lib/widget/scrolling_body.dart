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
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            color: index.isOdd ? Colors.white10 : Colors.white10,
            height: 250.0,
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 20,
                    width: 150,
                    child: Text('Blabla', //pull from db????
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 49, 5, 5))),
                  ),
                ),
                ListView.builder(
                  //This handles horizontal boxes.
                  scrollDirection: Axis.horizontal,
                  itemCount: 7, //pull from db!!!
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(20, 40, 20, 30),
                      width: 150,
                      color: Colors
                          .red, //there should be cover photo, name and genres!
                    );
                  },
                )
              ],
            )

            //add container(for exp: new releases) name from db and (see all) button!

            );
      },
      childCount: 10, //pull from db!
      //for favorites and subscriptions pages divide manga count with 3 if remaining value is over 0 add 1 to result
    ));
  }
}
