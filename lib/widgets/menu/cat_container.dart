import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/helpers/colors.dart';
import 'package:dish_connect/helpers/get_width.dart';
import 'package:dish_connect/pages/menu/category_row.dart';
import 'package:flutter/material.dart';

Widget categoryContainer(
  @required String name,
  @required String id,
  @required int index,
  BuildContext context,
) {
  var isLight = Theme.of(context).brightness == Brightness.light;
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      child: Container(
        width: getWidth(name, context) + 36,
        height: 44,
        decoration: BoxDecoration(
          color: isLight ? slate500 : Colors.black,
          borderRadius: BorderRadius.circular(
            10,
          ),
          border: Border(
            top: BorderSide(
              width: 2,
              color: selectedIndex == index ? mainBlue : Colors.transparent,
            ),
            bottom: BorderSide(
              width: 2,
              color: selectedIndex == index ? mainBlue : Colors.transparent,
            ),
            right: BorderSide(
              width: 2,
              color: selectedIndex == index ? mainBlue : Colors.transparent,
            ),
            left: BorderSide(
              width: 2,
              color: selectedIndex == index ? mainBlue : Colors.transparent,
            ),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        margin: EdgeInsets.fromLTRB(0, 0, 18, 0),
      ),
    ),
  );
}
