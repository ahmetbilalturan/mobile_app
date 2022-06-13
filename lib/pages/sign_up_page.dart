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
        return true;
      } else {
        return false;
      }
    } else {
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
                child: TextFormField(
                  controller: mailController,
                  decoration: InputDecoration(
                    labelText: 'E-Mail',
                    icon: const Icon(Icons.alternate_email),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.grey),
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
                  validator: (val) {
                    if (val != null) {
                      if (val.isEmpty) {
                        return 'Boş Bırakılamaz';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val)) {
                        return 'Geçerli Bir Email Adresi Girin';
                      } else {
                        return null;
                      }
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Kullanıcı Adı',
                    icon: const Icon(Icons.account_circle),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.grey),
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
                  validator: (val) {
                    if (val != null) {
                      if (val.isEmpty) {
                        return 'Boş Bırakılamaz';
                      } else {
                        return null;
                      }
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                    icon: const Icon(Icons.key),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.grey),
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
                  validator: (val) {
                    if (val != null) {
                      if (val.isEmpty) {
                        return 'Boş Bırakılamaz';
                      } else if (!comparePaswords(
                        passwordController.text,
                        passwordagainController.text,
                        nameController.text,
                        mailController.text,
                      )) {
                        return 'Şifreler Uyuşmuyor';
                      } else {
                        return null;
                      }
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordagainController,
                  decoration: InputDecoration(
                    labelText: 'Şifre Tekrar',
                    icon: const Icon(Icons.key),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.grey),
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
                  validator: (val) {
                    if (val != null) {
                      if (val.isEmpty) {
                        return 'Boş Bırakılamaz';
                      } else if (!comparePaswords(
                        passwordController.text,
                        passwordagainController.text,
                        nameController.text,
                        mailController.text,
                      )) {
                        return 'Şifreler Uyuşmuyor';
                      } else {
                        return null;
                      }
                    } else {
                      return null;
                    }
                  },
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
                      AuthService()
                          .adduser(nameController.text, passwordController.text,
                              mailController.text)
                          .then(
                        (val) {
                          if (val.data['success']) {
                            Fluttertoast.showToast(
                              msg: 'Başarıyla Kaydolundu',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            Navigator.of(context).pop();
                          }
                        },
                      );
                    }
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
