import 'package:dish_connect/pages/menu/menu.dart';
import 'package:flutter/material.dart';

const RootRoute = "/";

const HomePageRouteDisplayName = "Home";
const HomePageRoute = "/home";

const MenuPageRouteDisplayName = "Tailor Your Menu";
const MenuPageRoute = "/menu";

const ReservationsPageRouteDisplayName = "Reservations";
const ReservationsPageRoute = "/reservations";

const EventsPageRouteDisplayName = "Events";
const EventsPageRoute = "/events";

const PromotionsPageRouteDisplayName = "Promotions";
const PromotionsPageRoute = "/promotions";

const ManageFeaturesPageRouteDisplayName = "Manage Features";
const ManageFeaturesPageRoute = "/manage-features";

const AuthenticationPageRouteDisplayName = "Log Out";
const AuthenticationPageRoute = "/auth";

const LoadingPageRouteDisplayName = "Loading";
const LoadingPageRoute = "/loading";

const MainPageRouteDisplayName = "Loading";
const MainPageRoute = "/loading";

const SiteLayoutPageRouteDisplayName = "Home";
const SiteLayoutPageRoute = "/homee";

const CustomizeThemePageRouteDisplayName = "Customize Theme";
const CustomizeThemePageRoute = "/theme";

const AboutUsPageRouteDisplayName = "About Us";
const AboutUsPageRoute = "/about-us";

const GalleryPageRouteDisplayName = "Image Gallery";
const GalleryPageRoute = "/imagegallery";

const LocationPageRouteDisplayName = "Locations";
const LocationPageRoute = "/locations";

const SettingsPageRouteDisplayName = "Settings";
const SettingsPageRoute = "/settings";

const ViewImagePageRouteDisplayName = "View Image";
const ViewImagePageRoute = "/view-image";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItems = [
  MenuItem(HomePageRouteDisplayName, HomePageRoute),
  MenuItem(MenuPageRouteDisplayName, MenuPageRoute),
  MenuItem(ReservationsPageRouteDisplayName, ReservationsPageRoute),
  MenuItem(EventsPageRouteDisplayName, EventsPageRoute),
  MenuItem(PromotionsPageRouteDisplayName, PromotionsPageRoute),
  MenuItem(ManageFeaturesPageRouteDisplayName, ManageFeaturesPageRoute),
  MenuItem(AuthenticationPageRouteDisplayName, AuthenticationPageRoute),
];
