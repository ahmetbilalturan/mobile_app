import 'package:flutter/material.dart';
import 'package:test_app/utils/user_preferences.dart';
import 'package:test_app/widget/all_widgets.dart';
import 'package:test_app/widget/profile_widget.dart';

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
      backgroundColor: Colors.blue,
      drawer: const NavigationDrawerWidgetUser(),
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.red,
        title: const Text('Hoşgeldin Kullanıcı'),
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(imagePath: user.imagePath, onClicked: () async {})
        ],
      ),
    );
  }
}
