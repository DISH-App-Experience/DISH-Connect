import 'package:dish_connect/blocs/theme_provider.dart';
import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/controllers/menu_controller.dart';
import 'package:dish_connect/controllers/navigation_controller.dart';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/layout.dart';
import 'package:dish_connect/pages/404/error_page.dart';
import 'package:dish_connect/pages/authentication/authentication.dart';
import 'package:dish_connect/pages/authentication/loading_page.dart';
import 'package:dish_connect/pages/home/home.dart';
import 'package:dish_connect/routing/routes.dart';
import 'package:dish_connect/services/owner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyA2sL5q51LmueRGY6l8Q2tvH6KqSTLkaRI",
          appId: "1:668635512839:web:0408c9fc54a820ba8aaaa2",
          messagingSenderId: "668635512839",
          projectId: "dish-c7c56",
          databaseURL: "https://dish-c7c56-default-rtdb.firebaseio.com/"),
    );
  } else {
    await Firebase.initializeApp();
  }
  Get.put(MenuController());
  Get.put(NavigationController());
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    Widget authPage = AuthenticationPage();
    String authRoute = AuthenticationPageRoute;
    Widget loadingPage = LoadingPage();
    String loadingRoute = LoadingPageRoute;
    Widget homePage = SiteLayout();
    String homeRoute = HomePageRoute;
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DISH Connect',
        builder: EasyLoading.init(),
        color: isLight ? backgroundLight : backgroundDark,
        home:
            FirebaseAuth.instance.currentUser != null ? loadingPage : authPage,
        initialRoute: FirebaseAuth.instance.currentUser != null
            ? loadingRoute
            : authRoute,
        theme: ThemeData.light().copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: const FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.android: const FadeUpwardsPageTransitionsBuilder(),
            },
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: const FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.android: const FadeUpwardsPageTransitionsBuilder(),
            },
          ),
        ),
        themeMode: provider.themeMode,
        unknownRoute: GetPage(
          name: "/not-found",
          page: () => const ErrorPage(),
          transition: Transition.fadeIn,
        ),
        getPages: [
          GetPage(
            name: RootRoute,
            page: () => const SiteLayout(),
          ),
          GetPage(
            name: SiteLayoutPageRoute,
            page: () => const SiteLayout(),
          ),
          GetPage(
            name: LoadingPageRoute,
            page: () => const LoadingPage(),
          ),
          GetPage(
            name: AuthenticationPageRoute,
            page: () => const AuthenticationPage(),
          ),
        ],
      );
    });
  }
}
