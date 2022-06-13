import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/pages/login_page.dart';
import 'package:test_app/pages/screens.dart';
import 'package:test_app/services/authservices.dart';
import 'package:test_app/widget/all_widgets.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    late String username;
    String email;
    AuthService().getinfo(LoginPage.token).then((val) {
      if (val.data['success']) {
        username = val.data['username'].toString();
        email = val.data['email'].toString();
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
    return Scaffold(
      backgroundColor: Colors.blue,
      drawer: NavigationDrawerWidgetUser(
        name: username,
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
