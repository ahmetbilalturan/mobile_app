import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/pages/login_page.dart';
import 'package:test_app/pages/screens.dart';
import 'package:test_app/services/authservices.dart';
import 'package:test_app/widget/all_widgets.dart';

class MyHomePage extends StatefulWidget {
  static var username, email;
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    AuthService().getinfo(LoginPage.token).then((val) {
=======
    late String username;
    String email;
    username = val.data['username'].toString();
    /*AuthService().getinfo(LoginPage.token).then((val) {
>>>>>>> Stashed changes
      if (val.data['success']) {
        MyHomePage.username = val.data['username'];
        MyHomePage.email = val.data['email'];
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
    });*/
    return Scaffold(
      backgroundColor: Colors.blue,
      drawer: NavigationDrawerWidgetUser(
        name: MyHomePage.username.toString(),
      ), //push user id
      body: CustomScrollView(
        slivers: <Widget>[
          SliverHeader(title: widget.title),
          const ScrollingBody(), //push user id
        ],
      ),
    );
  }
}
