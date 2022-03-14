import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/helpers/responsiveness.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:flutter/material.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      elevation: 0,
      title: Row(
        children: [
          Visibility(
            child: CustomText(
              text: "DISH",
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).brightness == Brightness.light
                  ? navy500
                  : Colors.white,
            ),
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                color: Theme.of(context).brightness == Brightness.light
                    ? navy500
                    : Colors.white,
                onPressed: () {
                  print("hi");
                },
              ),
            ],
          ),
          SizedBox(
            width: 12,
          ),
          Container(
            width: 1,
            height: 22,
            color: Theme.of(context).brightness == Brightness.light
                ? navy500
                : Colors.white,
          ),
          SizedBox(
            width: 12,
          ),
          // CustomText(
          //   text: "Jorge Zapata",
          // ),
          // SizedBox(
          //   width: 16,
          // ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0), //add border radius
              child: Image.network(
                profileImageURL,
                width: 30,
                height: 30,
              ),
            ),
          ),
        ],
      ),
      iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.light
              ? navy500
              : Colors.white),
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? backgroundLight
          : backgroundDark,
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 14),
                  child: Container(
                    height: 28,
                    width: 28,
                    child: Image.asset('assets/images/rounded_icon.png'),
                  ),
                ),
              ],
            )
          : IconButton(
              onPressed: () {
                print("hi there");
                key.currentState?.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).brightness == Brightness.light
                    ? navy500
                    : Colors.white,
              ),
            ),
    );
