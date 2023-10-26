import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerFunctionsHelper {
  final picker = ImagePicker();
  Future<File?> pickImage(BuildContext context) async {
    print("Image Uploadinng.....");
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      print(croppedFile?.path.toString());
      if (croppedFile != null) {
        return File(croppedFile.path);
      } else {
        return null;
      }
    }
  }

  Future<List<File>?> pickMultipleImage(BuildContext context) async {
    print("Image Uploadinng.....");
    final pickedFile = await picker.pickMultiImage();

    if (pickedFile != null) {
      List<File> croppedFileList = [];
      for (int i = 0; i < pickedFile.length; i++) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile[i].path,
          aspectRatioPresets: [CropAspectRatioPreset.square],
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true,
            ),
            IOSUiSettings(
              title: 'Cropper',
            ),
            WebUiSettings(
              context: context,
            ),
          ],
        );
        if (croppedFile != null) {
          croppedFileList.add(File(croppedFile.path));
        } else {
          return null;
        }
      }
      return croppedFileList;
    }
  }

  void showPermissionError({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Permission Denied"),
        content: Text(
            "You have permanently denied storage permission. Please enable it in app settings."),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings(); // Opens app settings for the user to manually enable the permission.
            },
          ),
        ],
      ),
    );
  }

  Future<List<File>?> requestPermissionsAndPickMultipleFile(BuildContext context) async {
    List<File>? image;
    var status = await Permission.storage.status;
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;
    if (android.version.sdkInt < 33) {
      if (status.isGranted) {
        image = await pickMultipleImage(context);
      } else if (status.isDenied) {
        var result = await Permission.storage.request();
        if (result.isGranted) {
          image = await pickMultipleImage(context);
        } else {
          showPermissionError(context: context);
        }
      } else {
        showPermissionError(context: context);
      }
    } else {
      if (await Permission.photos.request().isGranted) {
        image = await pickMultipleImage(context);
      } else if (await Permission.photos.request().isPermanentlyDenied) {
        showPermissionError(context: context);
      } else if (await Permission.photos.request().isDenied) {
        showPermissionError(context: context);
      }
    }
    return image;

  }

  Future<File?> requestPermissionsAndPickFile(BuildContext context) async {
    File? image;
    var status = await Permission.storage.status;
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;
    if (android.version.sdkInt < 33) {
      if (status.isGranted) {
        image = await pickImage(context);
      } else if (status.isDenied) {
        var result = await Permission.storage.request();
        if (result.isGranted) {
          image = await pickImage(context);
        } else {
          showPermissionError(context: context);
        }
      } else {
        showPermissionError(context: context);
      }
    } else {
      if (await Permission.photos.request().isGranted) {
        image = await pickImage(context);
      } else if (await Permission.photos.request().isPermanentlyDenied) {
        showPermissionError(context: context);
      } else if (await Permission.photos.request().isDenied) {
        showPermissionError(context: context);
      }
    }
    return image;
  }
}
