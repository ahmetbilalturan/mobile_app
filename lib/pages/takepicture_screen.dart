import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class TakePictureScreen extends StatefulWidget {
  static XFile? imagetransferred;
  const TakePictureScreen({Key? key}) : super(key: key);

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image;

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      controller = CameraController(cameras![1], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print("NO any camera found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Capture Image from Camera"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
                child: controller == null
                    ? Center(child: Text("Loading Camera..."))
                    : !controller!.value.isInitialized
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : CameraPreview(controller!)),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        color: Color.fromARGB(119, 158, 158, 158),
                        child: IconButton(
                          padding: EdgeInsets.all(15),
                          iconSize: 35,
                          //image capture button
                          onPressed: () async {
                            try {
                              if (controller != null) {
                                //check if contrller is not null
                                if (controller!.value.isInitialized) {
                                  //check if controller is initialized
                                  image = await controller!
                                      .takePicture(); //capture image
                                  TakePictureScreen.imagetransferred = image;
                                  setState(
                                    () {
                                      //update UI
                                    },
                                  );
                                }
                                Navigator.of(context).pushNamed('/editphoto');
                                print('what');
                              }
                            } catch (e) {
                              print(e); //show error
                            }
                          },
                          icon: Icon(Icons.camera_alt),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
