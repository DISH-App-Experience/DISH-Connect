import 'package:flutter/material.dart';
import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/widgets/custom_back_button.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:get/get.dart';

class LocationManagerPage extends StatefulWidget {
  const LocationManagerPage({Key? key}) : super(key: key);

  @override
  State<LocationManagerPage> createState() => _LocationManagerPageState();
}

class _LocationManagerPageState extends State<LocationManagerPage> {
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: isLight ? Colors.white : navy500,
      body: SingleChildScrollView(
        child: Column(
          children: [CustomBackButton()],
        ),
      ),
    );
  }
}
