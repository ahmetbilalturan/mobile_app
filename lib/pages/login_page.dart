import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/services/authservices.dart';

class LoginPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  static var username, email, profilepicture, userid;

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
  OverlayEntry? entry;

  void showLoadingOverlay() {
    final overlay = Overlay.of(context)!;

    entry = OverlayEntry(
      builder: (context) => buildLoadingOverlay(),
    );

    overlay.insert(entry!);
  }

  void hideLoadingOverlay() {
    entry!.remove();
    entry = null;
  }

  Widget buildLoadingOverlay() => const Material(
        color: Colors.transparent,
        elevation: 8,
        child: Center(
          child: CircularProgressIndicator(
              color: Color.fromARGB(255, 163, 171, 192)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            child: Center(
              child: ListView(
                //mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                physics: const ClampingScrollPhysics(),
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: AspectRatio(
                      aspectRatio: 5,
                      child: Image.asset('png/manga-2.png'),
                    ),
                  ),
                  const SizedBox(height: 65),
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
                          setState(() {
                            WidgetsBinding.instance.addPostFrameCallback(
                                (_) => showLoadingOverlay());
                          });
                          AuthService().login(username, password).then(
                            (val) {
                              if (val.data['success']) {
                                AuthService().getinfo(val.data['token']).then(
                                  (val) {
                                    if (val.data['success']) {
                                      LoginPage.userid = val.data['userid'];
                                      LoginPage.email = val.data['email'];
                                      LoginPage.username = val.data['username'];
                                      LoginPage.profilepicture =
                                          val.data['profilepicture'];
                                      setState(() {
                                        hideLoadingOverlay();
                                      });
                                      Navigator.of(context)
                                          .popAndPushNamed('/homepage');
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: val.data['msg'],
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                      setState(() {
                                        hideLoadingOverlay();
                                      });
                                    }
                                  },
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: val.data['msg'],
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                setState(() {
                                  hideLoadingOverlay();
                                });
                              }
                            },
                          );
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
      ),
    );
  }
}
