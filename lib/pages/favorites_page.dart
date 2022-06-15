import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/pages/login_page.dart';
import 'package:test_app/widget/all_widgets.dart';

import '../services/authservices.dart';

class FavoritesPage extends StatefulWidget {
  final int userID;

  const FavoritesPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPage();
}

class _FavoritesPage extends State<FavoritesPage> {
  bool dataFetched = false;
  int lenght = 5;

  void getFavorites() async {
    setState(() {
      dataFetched = false;
    });
    await AuthService().getfavorites(LoginPage.username).then((val) {
      //val.data['array'] object arrayine atılacak daha sonra bu object arrayinden isim tür gibi veriler çekilecek
      if (val.data['success']) {
        print(val.data['array'].lenght[0]);
        Fluttertoast.showToast(
          msg: 'Veriler Çekildi',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    });
    setState(() {
      dataFetched = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      drawer: const NavigationDrawerWidgetUser(),
      body: CustomScrollView(
        slivers: [
          const SliverHeader(title: "Favoriler"),
          //push int values for scrolling body
          ScreenBody(lenght: lenght),
        ],
      ),
    );
  }
}
