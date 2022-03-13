import 'package:dish_connect/helpers/responsiveness.dart';
import 'package:dish_connect/widgets/horizontal_menu_item.dart';
import 'package:dish_connect/widgets/vertical_menu_item.dart';
import 'package:flutter/material.dart';

class SideMenuItem extends StatelessWidget {
  final String? name;
  final VoidCallback onTap;
  const SideMenuItem({Key? key, this.name, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomSize(context))
      return VerticalMenuItem(name: name ?? "", onTap: onTap);

    return HorizontalMenuItem(name: name ?? "", onTap: onTap);
  }
}
