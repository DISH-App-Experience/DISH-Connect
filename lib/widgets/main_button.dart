import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    this.buttonColor,
    this.function,
    this.widget,
    this.text,
  }) : super(key: key);

  final Color? buttonColor;
  final Function()? function;
  final Widget? widget;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: mainBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: CustomText(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            size: 15,
            text: text,
          ),
        ),
      ),
    );
  }
}
