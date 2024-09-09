import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerFunctionsHelper {
  static final picker = ImagePicker();
  static Future<File?> pickImage(BuildContext context,
      {bool forStory = false}) async {
    print("Image Uploadinng.....");
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: forStory
            ? const CropAspectRatio(ratioX: 9, ratioY: 16)
            : const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: forStory ? "Add Story" : "Cropper",
            toolbarColor: Theme.of(context).colorScheme.secondary,
            toolbarWidgetColor: Theme.of(context).colorScheme.onPrimary,
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

  static Future<List<File>?> pickMultipleImage(BuildContext context,
      {bool forStory = false}) async {
    print("Image Uploading.....");
    final pickedFiles = await picker.pickMultiImage(
      imageQuality: 85,
    );
    List<File>? croppedFileList = pickedFiles.map((e) => File(e.path)).toList();
    if (croppedFileList.isNotEmpty) {
      return cropMultipleImages(context, croppedFileList, forStory);
    }

    return null;
  }

  static Future<List<File>?> cropMultipleImages(
      BuildContext context, List<File> pickedFiles, bool forStory) async {
    print("Image Cropping.....");
    List<File> croppedFileList = [];

    for (int i = 0; i < pickedFiles.length; i++) {
      File? croppedFile = await _cropImage(
        context,
        pickedFiles[i].path,
        forStory
            ? const CropAspectRatio(ratioX: 9, ratioY: 16)
            : const CropAspectRatio(ratioX: 1, ratioY: 1),
      );

      if (croppedFile != null) {
        croppedFileList.add(croppedFile);
      } else {
        return null;
      }
    }

    return croppedFileList;
  }

  static Future<File?> _cropImage(BuildContext context, String sourcePath,
      CropAspectRatio aspectRatio) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: sourcePath,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        aspectRatio: aspectRatio,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).colorScheme.secondary,
            toolbarWidgetColor: Theme.of(context).colorScheme.onPrimary,
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
        print(croppedFile.path.toString());
        return File(croppedFile.path);
      }
    } catch (e) {
      print("Error cropping image: $e");
    }

    return null;
  }

  static void showPermissionError({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Permission Denied"),
        content: const Text(
            "You have permanently denied storage permission. Please enable it in app settings."),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings(); // Opens app settings for the user to manually enable the permission.
            },
          ),
        ],
      ),
    );
  }

  static Future<List<File>?> requestPermissionsAndPickMultipleFile(
      BuildContext context) async {
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

  static Future<File?> requestPermissionsAndPickFile(
      BuildContext context) async {
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

  static Future<File?> requestStoryPicker(BuildContext context) async {
    File? image;
    var status = await Permission.storage.status;
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;
    if (android.version.sdkInt < 33) {
      if (status.isGranted) {
        image = await pickImage(context, forStory: true);
      } else if (status.isDenied) {
        var result = await Permission.storage.request();
        if (result.isGranted) {
          image = await pickImage(context, forStory: true);
        } else {
          showPermissionError(context: context);
        }
      } else {
        showPermissionError(context: context);
      }
    } else {
      if (await Permission.photos.request().isGranted) {
        image = await pickImage(context, forStory: true);
      } else if (await Permission.photos.request().isPermanentlyDenied) {
        showPermissionError(context: context);
      } else if (await Permission.photos.request().isDenied) {
        showPermissionError(context: context);
      }
    }
    return image;
  }
}
