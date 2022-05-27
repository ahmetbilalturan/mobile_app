import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //basic search button. should pull userID for specific searchs.
    return Container(
        margin: const EdgeInsets.all(6.0),
        decoration:
            const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
        child: IconButton(
          icon: const Icon(Icons.search),
          iconSize: 30,
          color: Colors.white,
          onPressed: () {},
        ));
  }
}
