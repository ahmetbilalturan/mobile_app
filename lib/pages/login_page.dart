import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/services/authservices.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var username, password, token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: AspectRatio(
                aspectRatio: 5,
                child: Image.asset('png/manga-2.png'),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(),
                  labelText: 'Kullanıcı Adı',
                ),
                onChanged: (val) {
                  username = val;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.key),
                  border: OutlineInputBorder(),
                  labelText: 'Şifre',
                ),
                onChanged: (val) {
                  password = val;
                },
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/forgotpassword');
              },
              child: const Text(
                'Şifremi Unuttum',
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Giriş Yap'),
                onPressed: () {
                  AuthService().login(username, password).then((val) {
                    if (val.data['success']) {
                      token = val.data['token'];
                      Fluttertoast.showToast(
                        msg: 'Logined',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Hesabın yok mu?'),
                TextButton(
                  child: const Text(
                    'Kayıt Ol',
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
