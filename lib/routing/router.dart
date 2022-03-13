import 'package:dish_connect/pages/authentication/authentication.dart';
import 'package:dish_connect/pages/events/events.dart';
import 'package:dish_connect/pages/features/features.dart';
import 'package:dish_connect/pages/home/home.dart';
import 'package:dish_connect/pages/menu/menu.dart';
import 'package:dish_connect/pages/promos/promos.dart';
import 'package:dish_connect/pages/reservations/reservations.dart';
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
    default:
      return getPageRoute(HomePage());
  }
}

PageRoute getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
