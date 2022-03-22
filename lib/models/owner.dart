import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Owner {
  String name;
  String appId;
  String restaurant;
  String uid;
  String imageURL;

  Owner({
    required this.appId,
    required this.name,
    required this.restaurant,
    required this.uid,
    required this.imageURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'appId': appId,
      'name': name,
      'restaurant': restaurant,
      'uid': uid,
    };
  }
}
