import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/pages/home/gallery/web_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

uploadToStorage() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: false,
  );
  if (result != null && result.files.isNotEmpty) {
    print("done");
    final newPostKey = FirebaseDatabase.instance
        .ref()
        .child("App")
        .child(owner!.appId)
        .child("photos")
        .push()
        .key;
    final fileBytes = result.files.first.bytes;
    final fileName = result.files.first.name;
    // upload file
    await FirebaseStorage.instance
        .ref('App/${owner!.appId}/photos/${newPostKey}')
        .putData(fileBytes!);
    String downloadURL = await FirebaseStorage.instance
        .ref('App/${owner!.appId}/photos/${newPostKey}')
        .getDownloadURL();

    final postData = {
      'url': downloadURL,
      'key': newPostKey,
    };
    FirebaseDatabase.instance
        .ref()
        .child("Apps")
        .child(owner!.appId)
        .child("photos")
        .child(newPostKey!)
        .set(postData);
  } else {
    print("not done");
  }
}
