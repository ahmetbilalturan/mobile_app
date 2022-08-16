import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class PickImageScreen extends StatefulWidget {
  const PickImageScreen({Key? key}) : super(key: key);

  @override
  State<PickImageScreen> createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
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
    return Scaffold(
        backgroundColor: Colors.amber.shade300,
        //appBar: AppBar(title: Text('pick image')),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                        all: 10,
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
                                onClicked: () =>
                                    pickImage(ImageSource.gallery)),
                            buildButton(
                                title: 'Pick Camera',
                                icon: Icons.camera_alt_outlined,
                                onClicked: () => pickImage(ImageSource.camera)),
                          ],
                        ),
                      ),
                    ),
              const SizedBox(height: 24),
              const Text(
                'Image Picker',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48),
              Text(
                'Kullanıcı Adı',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 24),
              buildButton(
                  title: 'Pick Camera',
                  icon: Icons.camera_alt_outlined,
                  onClicked: () => pickImage(ImageSource.camera)),
            ],
          ),
        ));
  }
}
