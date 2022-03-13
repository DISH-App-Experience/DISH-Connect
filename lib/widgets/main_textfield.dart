import 'package:dish_connect/constants/colors.dart';
import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  final String? hintText;
  final bool? obscureText;
  final bool? isBirthday;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function()? function;

  const MainTextField({
    Key? key,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.isBirthday,
    this.function,
    this.controller,
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

    return TextFormField(
      onTap: () => {
        if (isBirthday == true) {function, print("hi there")}
      },
      keyboardType: keyboardType,
      cursorColor: mainBlue,
      cursorWidth: 2,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
    );
  }
}
