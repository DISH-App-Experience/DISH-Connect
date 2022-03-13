import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/constants/controllers.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HorizontalMenuItem extends StatelessWidget {
  final String? name;
  final VoidCallback onTap;
  const HorizontalMenuItem({Key? key, this.name, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    var isLight = Theme.of(context).brightness == Brightness.light;
    Color backgroundColor;
    Color hoverColor;
    Color hoverTextColor;
    Color selectedTextColor;
    if (isLight) {
      backgroundColor = slate500;
      hoverColor = Colors.white;
      hoverTextColor = Colors.black;
      selectedTextColor = Colors.black;
    } else {
      backgroundColor = Colors.black;
      hoverColor = navy500;
      hoverTextColor = Colors.white;
      selectedTextColor = Colors.white;
    }

    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.onHover(name ?? "")
            : menuController.onHover("not hovering");
      },
      child: Obx(
        () => Container(
          color: menuController.isHovering(name ?? "")
              ? hoverColor
              : backgroundColor,
          child: Row(
            children: [
              Visibility(
                visible: menuController.isHovering(name ?? "") ||
                    menuController.isActive(name ?? ""),
                child: Container(
                  width: 6,
                  height: 40,
                  color: Colors.blue,
                ),
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
              ),
              SizedBox(width: _width / 80),
              Padding(
                padding: EdgeInsets.all(
                  16,
                ),
                child: menuController.customImage(
                  name ?? "",
                  context,
                ),
              ),
              if (!menuController.isActive(name ?? ""))
                Flexible(
                  child: CustomText(
                    text: name ?? "",
                    color: menuController.isHovering(name ?? "")
                        ? hoverTextColor
                        : hoverTextColor,
                  ),
                )
              else
                Flexible(
                  child: CustomText(
                    text: name ?? "",
                    color: selectedTextColor,
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
