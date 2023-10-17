import 'dart:developer';
import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';

class FaceDetectionPage extends StatefulWidget {
  const FaceDetectionPage({super.key});

  @override
  State<FaceDetectionPage> createState() => _FaceDetectionPageState();
}

class _FaceDetectionPageState extends State<FaceDetectionPage> {
  File? faceImage;
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
            onFaceDetected: (face) => {
              if (face == null)
                {
                  print('No face detected'),
                }
              else
                {
                  log('Face detected ${face.toString()}'),
                }
            },
            onCapture: (File? image) {
              setState(() {
                log(image.toString());
                faceImage = image;
              });
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
