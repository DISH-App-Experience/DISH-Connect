import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = HomePageRouteDisplayName.obs;
  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  Widget customImage(String name, BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    switch (name) {
      case HomePageRouteDisplayName:
        if (isLight) {
          return Image.asset(
            "assets/images/home_light.png",
            width: 22,
            height: 22,
          );
        } else {
          return Image.asset(
            "assets/images/home_dark.png",
            width: 22,
            height: 22,
          );
        }
      case MenuPageRouteDisplayName:
        if (isLight) {
          return Image.asset(
            'assets/images/menu_light.png',
            width: 22,
            height: 22,
          );
        } else {
          return Image.asset(
            'assets/images/menu_dark.png',
            width: 22,
            height: 22,
          );
        }
      case ReservationsPageRouteDisplayName:
        if (isLight) {
          return Image.asset(
            'assets/images/reservations_light.png',
            width: 22,
            height: 22,
          );
        } else {
          return Image.asset(
            'assets/images/reservations_dark.png',
            width: 22,
            height: 22,
          );
        }
      case EventsPageRouteDisplayName:
        if (isLight) {
          return Image.asset(
            'assets/images/events_light.png',
            width: 22,
            height: 22,
          );
        } else {
          return Image.asset(
            'assets/images/events_dark.png',
            width: 22,
            height: 22,
          );
        }
      case PromotionsPageRouteDisplayName:
        if (isLight) {
          return Image.asset(
            'assets/images/promos_light.png',
            width: 22,
            height: 22,
          );
        } else {
          return Image.asset(
            'assets/images/promos_dark.png',
            width: 22,
            height: 22,
          );
        }
      case ManageFeaturesPageRouteDisplayName:
        if (isLight) {
          return Image.asset(
            'assets/images/manage_light.png',
            width: 22,
            height: 22,
          );
        } else {
          return Image.asset(
            'assets/images/manage_dark.png',
            width: 22,
            height: 22,
          );
        }
      case AuthenticationPageRouteDisplayName:
        if (isLight) {
          return Image.asset(
            'assets/images/logout_light.png',
            width: 22,
            height: 22,
          );
        } else {
          return Image.asset(
            'assets/images/logout_dark.png',
            width: 22,
            height: 22,
          );
        }
      default:
        if (isLight) {
          return Image.asset(
            'assets/images/logout_light.png',
            width: 22,
            height: 22,
          );
        } else {
          return Image.asset(
            'assets/images/logout_dark.png',
            width: 22,
            height: 22,
          );
        }
    }
  }

  Widget _customIcon(IconData icon, String itemName, BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    Color color;
    if (isLight) {
      color = navy500;
    } else {
      color = Colors.white;
    }
    if (isActive(itemName)) return Icon(icon, size: 22, color: Colors.pink);
    return Icon(
      icon, color: color,
      // isHovering(itemName) ? Colors.orange : Colors.yellow,
    );
  }
}
