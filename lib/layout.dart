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
  var profileURL = "";

  void getProfileURL() async {
    final ref = FirebaseDatabase.instance.ref();
    final appIdSnapshot = await ref
        .child("Users")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("appId")
        .get();
    final profileSnapshot = await ref
        .child("Apps")
        .child(appIdSnapshot.value as String)
        .child("appIcon")
        .get();
    setState(() {
      profileURL = profileSnapshot.value as String;
      print(profileURL);
    });
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    getProfileURL();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: isLight ? backgroundLight : backgroundDark,
      appBar: topNavigationBar(context, scaffoldKey),
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
