import 'package:dish_connect/models/menu_category.dart';
import 'package:dish_connect/models/owner.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Owner? owner;

final database =
    FirebaseDatabase.instance.ref().child("Apps").child(owner!.appId);

final rootRef =
    FirebaseDatabase.instance.ref().child("Apps").child(owner!.appId);

final themeRef = rootRef.child("theme");

final aboutRef = rootRef.child("about");

final locationRef = rootRef.child("locations");

final menuRef = rootRef.child("menu");

final menuItemRef = menuRef.child("items");

final menuCategoryRef = menuRef.child("categories");
