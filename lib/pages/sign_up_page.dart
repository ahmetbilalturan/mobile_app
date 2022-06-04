import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController mailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordagainController = TextEditingController();

  void comparePaswords(
      String password, String passwordagain, String name, String mail) {
    if (password != '' && passwordagain != '' && name != '' && mail != '') {
      if (password == passwordagain) {
        print('şifreler uyuşuyor');
      } else {
        print('şifreler uyuşmuyor');
      }
    } else {
      print('boş bırakılamaz');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
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
                controller: mailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-Mail',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kullanıcı Adı',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Şifre',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: passwordagainController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Şifre Tekrar',
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Kayıt Ol'),
                onPressed: () {
                  comparePaswords(
                      passwordController.text,
                      passwordagainController.text,
                      nameController.text,
                      mailController.text);
                  Navigator.of(context).pop();
                  //Navigator.of(context).pushNamed('/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
