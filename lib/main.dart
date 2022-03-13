import 'package:dish_connect/blocs/theme_provider.dart';
import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/controllers/menu_controller.dart';
import 'package:dish_connect/controllers/navigation_controller.dart';
import 'package:dish_connect/hello.dart';
import 'package:dish_connect/layout.dart';
import 'package:dish_connect/pages/404/error_page.dart';
import 'package:dish_connect/pages/authentication/authentication.dart';
import 'package:dish_connect/routing/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    var isUserLoggedIn = false;
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DISH Connect',
        builder: EasyLoading.init(),
        color: isLight ? backgroundLight : backgroundDark,
        home: isUserLoggedIn ? SiteLayout() : AuthenticationPage(),
        theme: ThemeData.light().copyWith(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            },
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            },
          ),
        ),
        themeMode: provider.themeMode,
        initialRoute: isUserLoggedIn ? HomePageRoute : AuthenticationPageRoute,
        unknownRoute: GetPage(
          name: "/not-found",
          page: () => ErrorPage(),
          transition: Transition.fadeIn,
        ),
        getPages: [
          GetPage(
            name: RootRoute,
            page: () => SiteLayout(),
          ),
          GetPage(
            name: AuthenticationPageRoute,
            page: () => AuthenticationPage(),
          ),
        ],
      );
    });
  }
}
