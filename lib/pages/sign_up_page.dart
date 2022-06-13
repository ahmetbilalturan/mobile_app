import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/services/authservices.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordagainController = TextEditingController();

  bool comparePaswords(
      String password, String passwordagain, String name, String mail) {
    if (password != '' && passwordagain != '' && name != '' && mail != '') {
      if (password == passwordagain) {
        Navigator.of(context).pop();
        print('şifreler uyuşuyor');
        return true;
      } else {
        print('şifreler uyuşmuyor');
        return false;
      }
    } else {
      print('boş bırakılamaz');
      return false;
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
        child: Form(
          key: _formKey,
          child: Column(
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
                    icon: Icon(Icons.alternate_email),
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
                    icon: Icon(Icons.account_circle),
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
                    icon: Icon(Icons.key),
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
                    icon: Icon(Icons.key),
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
                    if (_formKey.currentState!.validate()) {
                      if (comparePaswords(
                        passwordController.text,
                        passwordagainController.text,
                        nameController.text,
                        mailController.text,
                      )) {
                        AuthService()
                            .adduser(
                                nameController.text, passwordController.text)
                            .then(
                          (val) {
                            if (val.data['success']) {
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
                          },
                        );
                      }
                    }
                    //Navigator.of(context).pushNamed('/login');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
