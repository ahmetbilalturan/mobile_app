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
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            //color: index.isOdd ? Colors.white : Colors.black12,
            color: Colors.purple,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "container name",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => print("basıldı"),
                        icon: const Icon(Icons.abc),
                      )
                    ],
                  ),
                  Container(
                    height: 255,
                    color: Colors.red,
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              height: 175,
                              width: 125,
                              color: Colors.blue,
                              child: Text("photo"),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              height: 40,
                              width: 125,
                              color: Colors.green,
                              child: Text("artist and genre"),
                            )
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),

              //add container(for exp: new releases) name from db and (see all) button!
            ));
      },
      childCount: 10, //pull from db!
      //for favorites and subscriptions pages divide manga count with 3 if remaining value is over 0 add 1 to result
    ));
  }
}
