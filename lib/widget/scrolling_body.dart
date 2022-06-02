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
                    children: const [
                      ContainerName(
                        containerName: 'ContainerName',
                      ),
                      SeeAllButton(),
                      SizedBox(height: 30)
                    ],
                  ),
                  const WebtoonList(), //pull list from db
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

class SeeAllButton extends StatelessWidget {
  const SeeAllButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 15),
      ),
      onPressed: () => Navigator.of(context)
          .pushNamed("/seeall"), //navigate to container page
      child: const Text('Tümünü Gör'),
    );
  }
}

class ContainerName extends StatelessWidget {
  final String containerName;
  const ContainerName({
    Key? key,
    required this.containerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        containerName,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class WebtoonList extends StatelessWidget {
  const WebtoonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      color: Colors.red,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        scrollDirection: Axis.horizontal,
        itemCount: 7, //pull from db
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                  margin: //add cover photo from db later
                      const EdgeInsets.symmetric(horizontal: 10.0),
                  height: 175,
                  width: 125,
                  child: GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed("/seeall"),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'png/cover_page_2.png',
                          fit: BoxFit.fill,
                        ),
                      ))),
              Container(
                //pull artist name and genre from db
                margin: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                height: 40,
                width: 125,
                color: Colors.green,
                child: const Text("artist and genre"),
              )
            ],
          );
        },
      ),
    );
  }
}
