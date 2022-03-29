import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:dish_connect/widgets/cyclop/cyclop.dart';
import 'package:flutter/material.dart';

Widget colorRow(
  BuildContext context,
  String title,
  String id,
  Color color,
  ValueChanged<Color> onChangedColor,
  Function onPressed,
  Function selected,
) {
  Color myColor = color;
  var isLight = Theme.of(context).brightness == Brightness.light;
  return Container(
    height: 85,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8,
        ),
        CustomText(
          text: title,
          size: 12,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: 14,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width - 160,
              decoration: BoxDecoration(
                color: myColor,
                borderRadius: BorderRadius.circular(
                  10,
                ),
                border: Border(
                  top: BorderSide(
                    color: isLight ? backgroundDark : backgroundLight,
                    width: 1,
                  ),
                  right: BorderSide(
                    color: isLight ? backgroundDark : backgroundLight,
                    width: 1,
                  ),
                  left: BorderSide(
                    color: isLight ? backgroundDark : backgroundLight,
                    width: 1,
                  ),
                  bottom: BorderSide(
                    color: isLight ? backgroundDark : backgroundLight,
                    width: 1,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  print("hi there");
                  onPressed();
                },
                child: ColorButton(
                  key: Key('c1'),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: mainBlue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: 100,
                    height: 40,
                    child: Stack(
                      children: [
                        Container(
                          child: Center(
                            child: CustomText(
                              color: mainBlue,
                              size: 12,
                              text: "Change",
                              fontWeight: FontWeight.bold,
                              align: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  color: Colors.transparent,
                  config: ColorPickerConfig(
                    enableEyePicker: true,
                    enableLibrary: true,
                    enableOpacity: false,
                  ),
                  boxShape: BoxShape.rectangle,
                  size: 32,
                  selected: () {
                    selected();
                  },
                  onColorChanged: (value) {
                    var code = value.value.toRadixString(16);
                    if (code != "0") {
                      var hex = '#${code}';
                      var newCode = code.substring(1);
                      var newestCode = newCode.substring(1);
                      database.child("theme").child(id).set("#${newestCode}");
                      onChangedColor(value);
                    }
                  },
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
