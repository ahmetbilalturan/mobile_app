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
  bool dataFetched = false;

  void getName() async {
    setState(() {
      dataFetched = false;
    });
    await AuthService().getinfo(LoginPage.token).then((val) {
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
    });
    setState(() {
      dataFetched = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return dataFetched
        ? Scaffold(
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
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
