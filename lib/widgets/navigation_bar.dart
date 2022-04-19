import 'package:dish_connect/widgets/custom_text.dart';
import 'package:flutter/material.dart';

Widget navigationBar(BuildContext context, String title) => Container(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(
          top: 0,
          left: 25,
        ),
        child: CustomText(
          fontWeight: FontWeight.bold,
          size: 30,
          text: title,
        ),
      ),
    );

Widget smallNavigationBar(BuildContext context, String title) => Container(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(
          top: 15,
        ),
        child: CustomText(
          fontWeight: FontWeight.bold,
          size: 17,
          text: title,
        ),
      ),
    );
