import 'dart:developer';
import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socioverse/Models/authUserModels.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';

class FaceDetectionPage extends StatefulWidget {
  final SignupUser signupUser;

  FaceDetectionPage({super.key, required this.signupUser});

  @override
  State<FaceDetectionPage> createState() => _FaceDetectionPageState();
}

class _FaceDetectionPageState extends State<FaceDetectionPage> {
  List<File?>? faceImage;
  int numOfPics = 0;
  @override
  void initState() {
    numOfPics = 0;
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    faceImage = null;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          SmartFaceCamera(
            autoCapture: true,
            defaultCameraLens: CameraLens.front,
            showControls: false,
            showCaptureControl: false,
            showCameraLensControl: false,
            showFlashControl: false,
            indicatorShape: IndicatorShape.defaultShape,
            onCapture: (File? image) {
              if (numOfPics < 4) {
                setState(() {
                  faceImage!.add(image);
                });
                numOfPics++;
              } else {
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => MainPage(),
                    ),
                    (route) => route.isFirst);
              }
            },
          ),
          Center(
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    color: Colors.transparent),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
