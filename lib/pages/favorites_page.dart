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

  void getFavorites() async {
    setState(() {
      dataFetched = false;
    });
    await AuthService().getfavorites(LoginPage.username).then((val) {
      //val.data['array'] object arrayine atılacak daha sonra bu object arrayinden isim tür gibi veriler çekilecek
      if (val.data['success']) {
        print(val.data['array']);
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
    return const Scaffold(
      backgroundColor: Colors.purple,
      drawer: NavigationDrawerWidgetUser(),
      body: CustomScrollView(
        slivers: [
          SliverHeader(title: "Favoriler"),
          //push int values for scrolling body
          ScreenBody(),
        ],
      ),
    );
  }
}
