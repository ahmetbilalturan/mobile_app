import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/pages/login_page.dart';
import 'package:test_app/services/authservices.dart';

class LoadingPage extends StatefulWidget {
  static bool isLogined = false;
  static String currentRoute = '/homepage';
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late String userName, password;

  void tryToLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName') ?? '';
    password = prefs.getString('password') ?? '';
    await AuthService().login(userName.toString(), password.toString()).then(
      (val) async {
        if (val.data['success']) {
          await AuthService().getinfo(val.data['token']).then(
            (val) {
              if (val.data['success']) {
                LoadingPage.isLogined = true;
                LoginPage.userid = val.data['userid'];
                LoginPage.email = val.data['email'];
                LoginPage.username = val.data['username'];
                LoginPage.profilepicture = val.data['profilepicture'];
                Navigator.of(context).popAndPushNamed('/homepage');
              } else {
                Navigator.of(context).popAndPushNamed('/homepage');
              }
            },
          );
          Fluttertoast.showToast(
            msg: val.data['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          Navigator.of(context).popAndPushNamed('/homepage');
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    tryToLogin();
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFe699cb),
                Color(0xFFf3ccfb),
                Color(0xFFdce2f3),
                Color(0xFFd4fbcc),
                Color(0xFF73df99),
              ],
              stops: [
                0.03,
                0.25,
                0.5,
                0.85,
                1.6,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 6,
                  child: Image.asset('png/manga-2.png'),
                ),
                const SizedBox(height: 300),
                const CircularProgressIndicator(
                    color: Color.fromARGB(255, 163, 171, 192)),
                const SizedBox(height: 200),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: const Text(
                    'Yükleniyor...',
                    style: TextStyle(
                        color: Color(0xFF73df99),
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
