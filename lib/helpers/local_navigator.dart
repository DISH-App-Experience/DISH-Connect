import 'package:dish_connect/constants/controllers.dart';
import 'package:dish_connect/routing/router.dart';
import 'package:dish_connect/routing/routes.dart';
import 'package:flutter/material.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: HomePageRoute,
      onGenerateRoute: generateRoute,
    );
