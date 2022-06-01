import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomCancelButton extends StatelessWidget {
  const CustomCancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          color: Colors.transparent,
          width: 110,
          height: 50,
          child: Row(
            children: [
              Container(
                width: 15,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 14,
                  ),
                  CustomText(
                    text: "Cancel",
                    color: blue500,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
