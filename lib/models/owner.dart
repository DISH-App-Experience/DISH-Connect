import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Owner {
  final String appId;
  final String name;
  final String restaurant;
  final String uid;

  Owner({
    required this.appId,
    required this.name,
    required this.restaurant,
    required this.uid,
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
