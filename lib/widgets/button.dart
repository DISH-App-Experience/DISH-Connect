import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String name;
  const Button({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CustomText(
        text: name,
        size: 15,
        fontWeight: FontWeight.w600,
        color: mainBlue,
      ),
    );
  }
}
