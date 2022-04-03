import 'package:dish_connect/widgets/big_text_field.dart';
import 'package:dish_connect/widgets/main_textfield.dart';
import 'package:flutter/material.dart';

Widget webTextFieldRow(
  String placeholder,
  bool isBig,
  TextInputType keyboardType,
  TextEditingController controller,
  Function doneTyping,
) {
  double height;
  double tfHeight;
  if (isBig) {
    tfHeight = 196;
    height = 210;
  } else {
    height = 58;
    tfHeight = 44;
  }
  return Container(
    height: height,
    width: 725,
    child: Column(
      children: [
        SizedBox(
          height: 14,
        ),
        Container(
          height: tfHeight,
          child: isBig
              ? BigTextField(
                  hintText: placeholder,
                  keyboardType: keyboardType,
                  controller: controller,
                  onEditingCompletes: () {
                    doneTyping();
                  },
                )
              : MainTextField(
                  hintText: placeholder,
                  keyboardType: keyboardType,
                  controller: controller,
                  onEditingCompletes: () {
                    doneTyping();
                  },
                ),
        ),
      ],
    ),
  );
}
