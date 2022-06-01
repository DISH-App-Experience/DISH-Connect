import 'dart:ui';

import 'package:dish_connect/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? align;

  const CustomText(
      {Key? key, this.text, this.size, this.color, this.fontWeight, this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color defaultColor = Theme.of(context).brightness == Brightness.light
        ? navy500
        : Colors.white;
    return Text(
      text ?? "",
      textAlign: align,
      style: TextStyle(
        fontFamily: (fontWeight == FontWeight.bold) ? 'InterBold' : 'Inter',
        fontSize: size ?? 16,
        color: color ?? defaultColor,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
