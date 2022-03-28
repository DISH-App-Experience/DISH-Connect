import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/helpers/responsiveness.dart';
import 'package:dish_connect/widgets/large_screen.dart';
import 'package:dish_connect/widgets/side_menu.dart';
import 'package:dish_connect/widgets/small_screen.dart';
import 'package:dish_connect/widgets/top_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SiteLayout extends StatefulWidget {
  const SiteLayout({Key? key}) : super(key: key);

  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String appIconURL =
      "https://firebasestorage.googleapis.com/v0/b/dish-c7c56.appspot.com/o/App%2FbuzzBurger%2FappIcon?alt=media&token=65bb899e-ea21-4819-b353-9ef13edcd0af";
  @override
  Widget build(BuildContext context) {
    FirebaseDatabase.instance
        .ref('Apps/${owner!.appId}/appIcon')
        .once()
        .then((value) {
      setState(() {
        appIconURL = value.snapshot.value as String;
      });
    });
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: isLight ? backgroundLight : backgroundDark,
      appBar: topNavigationBar(context, scaffoldKey, appIconURL),
      body: ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
      ),
      drawer: Drawer(
        elevation: 0,
        backgroundColor: isLight ? slate500 : Colors.black,
        child: SideMenu(),
      ),
    );
  }
}
