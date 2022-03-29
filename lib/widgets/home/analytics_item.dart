import 'package:dish_connect/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget analyticItem(String name, int value, isTop) {
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  String numberString = myFormat.format(value);
  return Padding(
    padding: EdgeInsets.only(
      top: isTop ? 17 : 12,
      left: 25,
      right: 25,
    ),
    child: Stack(
      children: [
        Container(
          child: CustomText(
            text: name,
            align: TextAlign.left,
            color: Colors.white,
            size: 12,
          ),
          width: 282,
          height: 17,
        ),
        Container(
          child: CustomText(
            text: numberString,
            align: TextAlign.right,
            color: Colors.white,
            size: 12,
          ),
          width: 282,
          height: 17,
        ),
      ],
    ),
  );
}
