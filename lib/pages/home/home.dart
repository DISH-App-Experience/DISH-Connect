import 'package:dish_connect/controllers/navigation_controller.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:dish_connect/routing/router.dart';
import 'package:dish_connect/widgets/main_textfield.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        child: Text("Press me"),
        onPressed: () {
          FirebaseCrashlytics.instance.crash();
          print("hi");
        },
      ),
      // CustomText(
      //   text: "Home Page",
      // ),
    );
  }
}
