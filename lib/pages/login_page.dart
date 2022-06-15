import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/services/authservices.dart';

class LoginPage extends StatefulWidget {
  static late String token;

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var username, password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Giriş Yap'),
        centerTitle: true,
      ),
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.account_circle),
                      labelText: 'Kullanıcı Adı',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.lightBlue),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                    ),
                    onChanged: (val) {
                      username = val;
                    },
                    validator: (val) {
                      if (val != null) {
                        if (val.isEmpty) {
                          return 'Boş Bırakılamaz';
                        }
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.key),
                      labelText: 'Şifre',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.lightBlue),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                    ),
                    onChanged: (val) {
                      password = val;
                    },
                    validator: (val) {
                      if (val != null) {
                        if (val.isEmpty) {
                          return 'Boş Bırakılamaz';
                        }
                      }
                      return null;
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
                      if (_formKey.currentState!.validate()) {
                        AuthService().login(username, password).then(
                          (val) {
                            if (val.data['success']) {
                              LoginPage.token = val.data['token'];
                              Fluttertoast.showToast(
                                msg: 'Başarıyla Giriş Yapıldı',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              Navigator.of(context).pushNamed('/homepage',
                                  arguments: LoginPage.token);
                            }
                          },
                        );
                      } else {
                        print('error');
                      }
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
        ),
      ),
    );
  }
}
