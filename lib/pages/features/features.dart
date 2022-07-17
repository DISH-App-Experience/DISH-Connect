import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:dish_connect/widgets/navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeatureManagerPage extends StatefulWidget {
  const FeatureManagerPage({Key? key}) : super(key: key);

  @override
  State<FeatureManagerPage> createState() => _FeatureManagerPageState();
}

class _FeatureManagerPageState extends State<FeatureManagerPage> {
  Future<bool> seeIf(String id) async {
    var snap = await featuresRef.child(id).get();
    if (snap.exists) {
      return snap.value as bool;
    } else {
      return true;
    }
  }

  var themeIsEnabled = true;
  var menuIsEnabled = true;
  var locationsIsEnabled = true;
  var reservationsIsEnabled = true;
  var eventsIsEnabled = true;
  var promotionsIsEnabled = true;
  var galleryIsEnabled = true;
  var aboutUsIsEnabled = true;

  void backend() async {
    themeIsEnabled = await seeIf("customTheme");
    menuIsEnabled = await seeIf("managableMenu");
    locationsIsEnabled = await seeIf("addLocations");
    reservationsIsEnabled = await seeIf("reservationRequests");
    eventsIsEnabled = await seeIf("newsEvents");
    promotionsIsEnabled = await seeIf("sendPromos");
    galleryIsEnabled = await seeIf("imageGallery");
    aboutUsIsEnabled = await seeIf("aboutUs");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    backend();

    Widget featureRow(
      String title,
      String id,
      String imgName,
      bool disabled,
      bool isSmall,
    ) {
      bool value = true;
      switch (title) {
        case "Custom Theme":
          value = themeIsEnabled;
          break;
        case "Digital Menu":
          value = menuIsEnabled;
          break;
        case "Locations":
          value = locationsIsEnabled;
          break;
        case "Reservations":
          value = reservationsIsEnabled;
          break;
        case "Events":
          value = eventsIsEnabled;
          break;
        case "Promotions":
          value = promotionsIsEnabled;
          break;
        case "Image Gallery":
          value = galleryIsEnabled;
          break;
        case "About Us":
          value = aboutUsIsEnabled;
          break;
      }
      return Container(
        height: 50,
        child: Column(
          children: [
            Container(
              height: 35,
              child: Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        color: Colors.green,
                        // decoration: BoxDecoration(
                        //   image: DecorationImage(
                        //     image: AssetImage(
                        //       "images/${imgName}.png",
                        //     ),
                        //   ),
                        // ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: 153,
                        child: CustomText(
                          text: title,
                          size: 16,
                          align: TextAlign.left,
                        ),
                      ),
                      !isSmall
                          ? SizedBox(
                              width: 150,
                            )
                          : Container(),
                      !isSmall
                          ? Container(
                              height: 35,
                              width: 35,
                              color: Colors.green,
                            )
                          : Container(),
                    ],
                  ),
                  if (isSmall)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 35,
                          width: 65,
                          child: Center(
                            child: CupertinoSwitch(
                              value: value,
                              activeColor: mainBlue,
                              onChanged: (bool selected) {
                                switch (id) {
                                  case "customTheme":
                                    print("tried switching");
                                    setState(() {
                                      themeIsEnabled = !themeIsEnabled;
                                    });
                                    break;
                                  case "digitalMenu":
                                  case "locations":
                                  case "reservationRequests":
                                  case "events":
                                  case "promotions":
                                  case "images":
                                  case "aboutUs":
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),
            Container(
              height: 15,
            ),
          ],
        ),
      );
    }

    var isLight = Theme.of(context).brightness == Brightness.light;
    var isSmall = MediaQuery.of(context).size.width < 1210;
    return Scaffold(
      backgroundColor: isLight ? Colors.white : navy500,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            isSmall
                ? navigationBar(
                    context,
                    "Manage Features",
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      left: 55,
                    ),
                    child: Container(
                      width: double.infinity,
                      child: CustomText(
                        text: "Manage Features",
                        fontWeight: FontWeight.bold,
                        align: TextAlign.left,
                        size: 50,
                      ),
                    ),
                  ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: isSmall ? 25 : 55,
                right: isSmall ? 25 : 55,
              ),
              child: Column(
                children: [
                  featureRow(
                    "Custom Theme",
                    "customTheme",
                    "themeIcon",
                    true,
                    isSmall,
                  ),
                  featureRow(
                    "Digital Menu",
                    "digitalMenu",
                    "menuIcon",
                    true,
                    isSmall,
                  ),
                  featureRow(
                    "Locations",
                    "locations",
                    "locationIcon",
                    false,
                    isSmall,
                  ),
                  featureRow(
                    "Reservations",
                    "reservationRequests",
                    "reservationIcon",
                    false,
                    isSmall,
                  ),
                  featureRow(
                    "Events",
                    "events",
                    "eventsIcon",
                    false,
                    isSmall,
                  ),
                  featureRow(
                    "Promotions",
                    "promotions",
                    "promotionsIcon",
                    false,
                    isSmall,
                  ),
                  featureRow(
                    "Image Gallery",
                    "images",
                    "imagesIcon",
                    false,
                    isSmall,
                  ),
                  featureRow(
                    "About Us",
                    "aboutUs",
                    "aboutIcon",
                    false,
                    isSmall,
                  ),
                  Container(
                    height: 150,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
