
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseHelper {
    
  static Future<String> uploadFile(String filePath, String fileName, String path) async {
    String downloadURL = '';
    try {
      Reference ref = FirebaseStorage.instance.ref(path).child(fileName);
      UploadTask uploadTask = ref.putFile(File(filePath));
      await uploadTask.whenComplete(() async {
        downloadURL = await ref.getDownloadURL();
      });
    } catch (e) {
      print(e);
    }
    return downloadURL;
  }
  static Future<void> deleteFolder(String folderName)
  async{
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
}