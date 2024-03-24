import 'dart:developer';
import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socioverse/Models/authUserModels.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';

class FaceDetectionPage extends StatefulWidget {
  const FaceDetectionPage({super.key});

  @override
  State<FaceDetectionPage> createState() => _FaceDetectionPageState();
}

class _FaceDetectionPageState extends State<FaceDetectionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SmartFaceCamera(
        autoCapture: true,
        defaultCameraLens: CameraLens.front,
        showControls: false,
        showCaptureControl: false,
        showCameraLensControl: false,
        showFlashControl: false,
        indicatorShape: IndicatorShape.defaultShape,
        onCapture: (File? image) {
          Navigator.pop(context, [image]);
        },
      ),
    ));
  }
}
