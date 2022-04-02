import 'dart:async';
import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/constants/controllers.dart';
import 'package:dish_connect/helpers/colors.dart';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/layout.dart';
import 'package:dish_connect/models/owner.dart';
import 'package:dish_connect/models/theme.dart';
import 'package:dish_connect/pages/home/home.dart';
import 'package:dish_connect/pages/home/theme/customize_theme.dart';
import 'package:dish_connect/routing/routes.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import '../../services/owner.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final databaseReference = FirebaseDatabase.instance.reference();
  double boxX = 0;
  double boxY = 0;

  void moveBox() {
    setState(() {
      boxX = 0;
      boxY = -0.125;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(milliseconds: 1), () {
      moveBox();
    });

    var ownerRef = databaseReference
        .child("Users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    ownerRef.child("appId").once().then(
      (appIdValue) {
        ownerRef.child("name").once().then(
          (nameValue) {
            ownerRef.child("restaurant").once().then(
              (restaurantValue) {
                var appId = appIdValue.snapshot.value as String;
                var name = nameValue.snapshot.value as String;
                var restaurant = restaurantValue.snapshot.value as String;
                var resRef = databaseReference.child("Apps").child(appId);
                resRef.child("appIcon").once().then(
                  (appIconValue) {
                    var imageUrl = appIconValue.snapshot.value as String;
                    print("image url is" + imageUrl);
                    owner = Owner(
                      appId: appId,
                      name: name,
                      restaurant: restaurant,
                      uid: FirebaseAuth.instance.currentUser!.uid,
                    );

                    Timer(Duration(seconds: 2), () {
                      Get.off(
                        SiteLayout(),
                        fullscreenDialog: true,
                      );
                    });
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: isLight ? backgroundLight : backgroundDark,
      body: Center(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 65),
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              alignment: Alignment(boxX, boxY),
              child: Container(
                height: 90,
                width: 90,
                child: Image.asset(
                  'assets/images/rounded_icon.png',
                  height: 90,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
