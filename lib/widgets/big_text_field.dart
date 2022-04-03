import 'package:dish_connect/constants/colors.dart';
import 'package:flutter/material.dart';

class BigTextField extends StatelessWidget {
  final String? hintText;
  final bool? obscureText;
  final bool? isBirthday;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function()? function;
  final Function()? onEditingCompletes;

  const BigTextField({
    Key? key,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.isBirthday,
    this.function,
    this.controller,
    this.onEditingCompletes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    Color secColor;
    if (isLight) {
      secColor = slate500;
    } else {
      secColor = darkTFBackground;
    }

    return SizedBox(
      height: 50,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.top,
        onTap: () => {
          if (isBirthday == true) {function, print("hi there")}
        },
        keyboardType: keyboardType,
        cursorColor: mainBlue,
        cursorWidth: 2,
        expands: true,
        maxLines: null,
        minLines: null,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
          filled: true,
          fillColor: secColor,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: secColor,
              width: .2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: secColor,
              width: .2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: secColor,
              width: .2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        obscureText: obscureText!,
        controller: controller,
        onChanged: (s) {
          if (onEditingCompletes != null) {
            onEditingCompletes!();
          }
        },
      ),
    );
  }
}
