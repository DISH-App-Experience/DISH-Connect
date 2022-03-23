import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/widgets/custom_back_button.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomizeThemePage extends StatefulWidget {
  const CustomizeThemePage({Key? key}) : super(key: key);

  @override
  State<CustomizeThemePage> createState() => _CustomizeThemePageState();
}

class _CustomizeThemePageState extends State<CustomizeThemePage> {
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
