import 'package:dish_connect/pages/authentication/authentication.dart';
import 'package:dish_connect/pages/events/events.dart';
import 'package:dish_connect/pages/features/features.dart';
import 'package:dish_connect/pages/home/about_us.dart';
import 'package:dish_connect/pages/home/customize_theme.dart';
import 'package:dish_connect/pages/home/home.dart';
import 'package:dish_connect/pages/home/images.dart';
import 'package:dish_connect/pages/home/locations.dart';
import 'package:dish_connect/pages/menu/menu.dart';
import 'package:dish_connect/pages/promos/promos.dart';
import 'package:dish_connect/pages/reservations/reservations.dart';
import 'package:dish_connect/pages/settings/settings.dart';
import 'package:dish_connect/routing/routes.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePageRoute:
      return getPageRoute(HomePage());
    case MenuPageRoute:
      return getPageRoute(MenuPage());
    case ReservationsPageRoute:
      return getPageRoute(ReservationsPage());
    case EventsPageRoute:
      return getPageRoute(EventsPage());
    case PromotionsPageRoute:
      return getPageRoute(PromotionsPage());
    case ManageFeaturesPageRoute:
      return getPageRoute(FeatureManagerPage());
    case AuthenticationPageRoute:
      return getPageRoute(AuthenticationPage());
    case CustomizeThemePageRoute:
      return getPageRoute(CustomizeThemePage());
    case AboutUsPageRoute:
      return getPageRoute(AboutUsPage());
    case GalleryPageRoute:
      return getPageRoute(ImageGallery());
    case LocationPageRoute:
      return getPageRoute(LocationManagerPage());
    case SettingsPageRoute:
      return getPageRoute(SettingsPage());
    default:
      return getPageRoute(HomePage());
  }
}

PageRoute getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
