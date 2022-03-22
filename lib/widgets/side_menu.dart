import 'package:dish_connect/pages/authentication/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/constants/controllers.dart';
import 'package:dish_connect/helpers/responsiveness.dart';
import 'package:dish_connect/routing/routes.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:dish_connect/widgets/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      color: isLight ? slate500 : Colors.black,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: _width / 48,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 12,
                      ),
                      child: Image.asset(
                        "assets/images/rounded_icon.png",
                        height: 30,
                        width: 30,
                      ),
                    ),
                    Flexible(
                      child: CustomText(
                        text: "DISH",
                        size: 20,
                        fontWeight: FontWeight.bold,
                        color: mainBlue,
                      ),
                    ),
                    SizedBox(width: _width / 48),
                    SizedBox(
                      height: 40,
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItems
                  .map((item) => SideMenuItem(
                        name: item.name,
                        onTap: () async {
                          if (item.route == AuthenticationPageRoute) {
                            await FirebaseAuth.instance.signOut();
                            menuController
                                .changeActiveItemTo(HomePageRouteDisplayName);
                            Get.offAllNamed(AuthenticationPageRoute);
                          }
                          if (!menuController.isActive(item.name)) {
                            menuController.changeActiveItemTo(item.name);
                            if (ResponsiveWidget.isSmallScreen(context))
                              Get.back();
                            navigationController.navigateTo(item.route);
                          }
                        },
                      ))
                  .toList()),
        ],
      ),
    );
  }
}
