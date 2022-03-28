import 'dart:io';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  static UploadTask? uploadFile(File file) {
    try {
      final ref = FirebaseStorage.instance.ref('App/${owner!.appId}/appIcon');
      Uint8List uint8list = Uint8List.fromList(file.readAsBytesSync());
      return ref.putData(uint8list);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
