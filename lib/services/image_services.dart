import 'package:dish_connect/helpers/global_variables.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final photosRef = FirebaseDatabase.instance
    .ref()
    .child("Apps")
    .child(owner!.appId)
    .child("photos");
