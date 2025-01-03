import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseHelper {
  static String Image = 'image/jpeg';
  static String Video = 'video/mp4';
  static String Audio = 'audio/mpeg';
  static String Document = 'application/pdf';
  static String Text = 'text/plain';

  static Future<String> uploadFile(
      String filePath, String fileName, String path, String contentType) async {
    String downloadURL = '';
    try {
      Reference ref = FirebaseStorage.instance.ref(path).child(fileName);
      UploadTask uploadTask = ref.putFile(
          File(filePath), SettableMetadata(contentType: contentType));
      await uploadTask.whenComplete(() async {
        downloadURL = await ref.getDownloadURL();
      });
    } catch (e) {
      print(e);
    }
    return downloadURL;
  }

  static Future<void> deleteFolder(String folderName) async {
    try {
      Reference ref = FirebaseStorage.instance.ref(folderName);
      ref.listAll().then((value) {
        value.items.forEach((element) {
          element.delete();
        });
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteFileByUrl(String fileURL) async {
    try {
      Reference ref = FirebaseStorage.instance.refFromURL(fileURL);
      await ref.delete();
    } catch (e) {
      print(e);
    }
  }
}
