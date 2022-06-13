import 'package:flutter/material.dart';
import 'package:test_app/utils/user_preferences.dart';
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
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.blue,
      drawer: const NavigationDrawerWidgetUser(name: 's'),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(imagePath: user.imagePath, onClicked: () async {}),
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
        ],
      ),
    );
  }

  String name = 'Kullanıcı Adı: ';
  String email = 'E-posta: ';

  Widget buildName(User user) => Column(
        children: [
          Text(
            name + user.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            email + user.email,
            style: TextStyle(
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
}
