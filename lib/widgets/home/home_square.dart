import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/constants/controllers.dart';
import 'package:dish_connect/routing/routes.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:flutter/material.dart';

Widget square(
  String iconText,
  String miniHeader,
  String mainHeader,
  BuildContext context,
) {
  var isLight = Theme.of(context).brightness == Brightness.light;
  return GestureDetector(
    onTap: () {
      switch (mainHeader) {
        case "Theme":
          navigationController.navigateTo(CustomizeThemePageRoute);
          break;
        case "Menu":
          var item = MenuItem(MenuPageRouteDisplayName, MenuPageRoute);
          menuController.changeActiveItemTo(item.name);
          navigationController.navigateTo(MenuPageRoute);
          break;
        case "About Us":
          navigationController.navigateTo(AboutUsPageRoute);
          break;
        case "Images":
          navigationController.navigateTo(GalleryPageRoute);
          break;
        case "Locations":
          navigationController.navigateTo(LocationPageRoute);
          break;
        case "Settings":
          navigationController.navigateTo(SettingsPageRoute);
          break;
      }
    },
    child: Padding(
      padding: EdgeInsets.only(
        top: 25,
        left: 25,
      ),
      child: Container(
        width: ((MediaQuery.of(context).size.width - 75) / 2),
        decoration: BoxDecoration(
          color: isLight ? blue100 : Colors.black,
          borderRadius: BorderRadius.circular(25),
        ),
        height: ((MediaQuery.of(context).size.width - 75) / 2),
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            // SizedBox(
            //   height: 45,
            // ),
            Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Container(
                child: Text(
                  iconText,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                width: ((MediaQuery.of(context).size.width - 75) / 2),
                height: 32,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 12,
                left: 15,
                right: 15,
              ),
              child: Container(
                child: CustomText(
                  text: miniHeader,
                  fontWeight: FontWeight.bold,
                  size: 12,
                ),
                width: ((MediaQuery.of(context).size.width - 62.5) / 2),
                height: 13,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 9,
                left: 15,
                right: 15,
              ),
              child: Container(
                child: CustomText(
                  text: mainHeader,
                  color: mainBlue,
                  fontWeight: FontWeight.bold,
                  size: 25,
                ),
                width: ((MediaQuery.of(context).size.width - 75) / 2),
                height: 32,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
