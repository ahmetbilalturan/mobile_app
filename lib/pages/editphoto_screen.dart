import 'dart:io';
import 'package:flutter/material.dart';
import 'package:test_app/pages/takepicture_screen.dart';
import 'package:photo_view/photo_view.dart';

class EditPhotoScreen extends StatefulWidget {
  const EditPhotoScreen({Key? key}) : super(key: key);

  @override
  State<EditPhotoScreen> createState() => _EditPhotoScreenState();
}

class _EditPhotoScreenState extends State<EditPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Image"),
          backgroundColor: Colors.redAccent,
        ),
        body: PhotoView.customChild(
          child: Image.file(
            File(TakePictureScreen.imagetransferred!.path),
            //height: 200,
          ),
        )
        //display captured image
        );
  }
}
