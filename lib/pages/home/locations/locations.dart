import 'package:dish_connect/widgets/navigation_bar.dart';
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
    var isSmall = MediaQuery.of(context).size.width < 1210;
    return Scaffold(
      backgroundColor: isLight ? Colors.white : navy500,
      body: isSmall
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBackButton(),
                  navigationBar(
                    context,
                    "Locations",
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBackButton(),
                  navigationBar(
                    context,
                    "Locations",
                  ),
                ],
              ),
            ),
    );
  }
}
