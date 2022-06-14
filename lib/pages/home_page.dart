import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/model/user.dart';
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
        User MyUser = User(
            imagePath:
                'https://scontent.fist10-1.fna.fbcdn.net/v/t1.18169-9/185137_358350839969_7617085_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=973b4a&_nc_ohc=FQ5vSYs0i7QAX8_cbr2&_nc_ht=scontent.fist10-1.fna&oh=00_AT-yn5WhuLp7fNW8ZNvd9-ICNrp2hYCswrhIdDB-nV1f-w&oe=62CB4E03',
            name: val.data['username'].toString(),
            email: val.data['email'].toString());
        /*MyHomePage.username = val.data['username'];
        MyHomePage.email = val.data['email'];*/
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
