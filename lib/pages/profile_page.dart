import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_app/pages/login_page.dart';
import 'package:test_app/pages/takepicture_screen.dart';
import 'package:test_app/widget/all_widgets.dart';
import 'package:test_app/widget/appbar_widget.dart';
import 'package:test_app/widget/button_widget.dart';
import 'package:test_app/widget/profile_widget.dart';
import 'package:test_app/model/user.dart';

class ProfilePage extends StatefulWidget {
  final int userID;
  final String title;
  const ProfilePage({Key? key, required this.title, required this.userID})
      : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget buildButton(
      {required String title,
      required IconData icon,
      required VoidCallback onClicked}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        primary: Colors.white,
        onPrimary: Colors.black,
        textStyle: const TextStyle(fontSize: 20),
      ),
      onPressed: onClicked,
      child: Row(
        children: [
          Icon(icon, size: 28),
          const SizedBox(
            width: 16,
          ),
          Text(title),
        ],
      ),
    );
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
  Widget buildEditIcon({
    required Color color,
    required double size,
    required IconData icon,
    required double all,
  }) =>
      buildCircle(
        color: Colors.white,
        all: all,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            icon,
            color: Colors.white,
            size: size,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    User user = User(
        imagePath:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/640px-A_black_image.jpg',
        name: 'Default Username',
        email: 'Default E-mail');
    user.setName(LoginPage.username);
    user.setEmail(LoginPage.email);
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.blue,
      drawer: const NavigationDrawerWidgetUser(),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            image != null
                ? Stack(
                    children: [
                      InkWell(
                        child: ClipOval(
                          child: Image.file(
                            image!,
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                        onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              buildButton(
                                title: 'Pick Gallery',
                                icon: Icons.image_outlined,
                                onClicked: () {
                                  pickImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                              ),
                              buildButton(
                                title: 'Pick Camera',
                                icon: Icons.camera_alt_outlined,
                                onClicked: () {
                                  pickImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: buildEditIcon(
                          color: Colors.black,
                          size: 20,
                          icon: Icons.edit,
                          all: 3,
                        ),
                      ),
                    ],
                  )
                : InkWell(
                    child: buildEditIcon(
                      color: Colors.black,
                      size: 120,
                      icon: Icons.camera_alt_outlined,
                      all: 5,
                    ),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          buildButton(
                              title: 'Pick Gallery',
                              icon: Icons.image_outlined,
                              onClicked: () => pickImage(ImageSource.gallery)),
                          buildButton(
                              title: 'Pick Camera',
                              icon: Icons.camera_alt_outlined,
                              onClicked: () => pickImage(ImageSource.camera)),
                        ],
                      ),
                    ),
                  ),
            const SizedBox(
              height: 24,
            ),
            const SizedBox(
              height: 24,
            ),
            buildName(user),
            const SizedBox(
              height: 24,
            ),
            Center(child: buildPasswordButton(user)),
            Center(child: buildApplyButton(user)),
          ],
        ),
      ),
    );
  }

  String name = 'Kullanıcı Adı: ';
  String email = 'E-posta: ';

  Widget buildName(User user) => Column(
        children: [
          Text(
            name + user.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            email + user.email,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      );

  Widget buildPasswordButton(User user) => ButtonWidget(
        text: 'Şifre Değiştir',
        onClicked: () {},
      );
  Widget buildApplyButton(User user) => ButtonWidget(
        text: 'Çizer Olmak İstiyorsan Başvur!',
        onClicked: () {},
      );
}
