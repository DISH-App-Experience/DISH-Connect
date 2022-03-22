import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/controllers/navigation_controller.dart';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/helpers/responsiveness.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:dish_connect/routing/router.dart';
import 'package:dish_connect/widgets/main_button.dart';
import 'package:dish_connect/widgets/main_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var users = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findAllUsers();
  }

  void findAllUsers() {
    FirebaseDatabase.instance
        .ref()
        .child("Apps")
        .child(owner!.appId)
        .child("Users")
        .onValue
        .listen((event) {
      for (final child in event.snapshot.children) {
        setState(() {
          users++;
        });
      }
    });
  }

  Widget square(
    String iconText,
    String miniHeader,
    String mainHeader,
    BuildContext context,
  ) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: () {
        print("hi");
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: 25,
          left: 25,
        ),
        child: Container(
          width: ((MediaQuery.of(context).size.width - 75) / 2),
          decoration: BoxDecoration(
            color: isLight ? blue100 : Colors.black,
            borderRadius: BorderRadius.circular(25),
          ),
          height: ((MediaQuery.of(context).size.width - 75) / 2),
          child: Column(
            children: [
              SizedBox(
                height: 43,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  child: Text(
                    iconText,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  width: ((MediaQuery.of(context).size.width - 75) / 2),
                  height: 32,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 12,
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  child: CustomText(
                    text: miniHeader,
                    fontWeight: FontWeight.bold,
                    size: 12,
                  ),
                  width: ((MediaQuery.of(context).size.width - 62.5) / 2),
                  height: 13,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 9,
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  child: CustomText(
                    text: mainHeader,
                    color: mainBlue,
                    fontWeight: FontWeight.bold,
                    size: 25,
                  ),
                  width: ((MediaQuery.of(context).size.width - 75) / 2),
                  height: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rectangle(
    String miniHeader,
    String mainHeader,
    BuildContext context,
    bool isAnalytics,
  ) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    Color backgroundColor = isLight ? blue100 : Colors.black;
    Color textColor = isLight ? navy500 : Colors.white;
    return GestureDetector(
      onTap: () {
        print("hi");
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: 25,
          left: 25,
        ),
        child: Container(
          width: ((MediaQuery.of(context).size.width - 75) / 2),
          decoration: BoxDecoration(
            color: isAnalytics ? mainBlue : backgroundColor,
            borderRadius: BorderRadius.circular(25),
          ),
          height: 90,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  child: CustomText(
                    text: miniHeader,
                    fontWeight: FontWeight.bold,
                    color: isAnalytics ? Colors.white : textColor,
                    size: 12,
                  ),
                  width: ((MediaQuery.of(context).size.width - 75) / 2),
                  height: 13,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 5,
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  child: Text(
                    mainHeader,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: isAnalytics ? Colors.white : mainBlue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  width: ((MediaQuery.of(context).size.width - 75) / 2),
                  height: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget webSquare(
    String iconText,
    String miniHeader,
    String mainHeader,
    BuildContext context,
  ) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          print("hi");
        },
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            color: isLight ? blue100 : Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          height: ((MediaQuery.of(context).size.width - 75) / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 55,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  child: Text(
                    iconText,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  width: ((MediaQuery.of(context).size.width - 75) / 2),
                  height: 32,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 12,
                  left: 15,
                  right: 15,
                ),
                child: Container(
                  child: CustomText(
                    text: miniHeader,
                    fontWeight: FontWeight.bold,
                    size: 12,
                  ),
                  width: ((MediaQuery.of(context).size.width - 62.5) / 2),
                  height: 13,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 9,
                  left: 15,
                  right: 15,
                  bottom: 25,
                ),
                child: Container(
                  child: CustomText(
                    text: mainHeader,
                    color: mainBlue,
                    fontWeight: FontWeight.bold,
                    size: 30,
                  ),
                  width: ((MediaQuery.of(context).size.width - 75) / 2),
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    double _width = MediaQuery.of(context).size.width;
    var screenWidth = MediaQuery.of(context).size.width;
    if (_width >= mediumScreenSize) {
      return Scaffold(
        backgroundColor: isLight ? backgroundLight : backgroundDark,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 55,
                ),
                child: Container(
                  width: double.infinity,
                  child: CustomText(
                    text: "Welcome",
                    fontWeight: FontWeight.bold,
                    align: TextAlign.left,
                    size: 50,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 55,
                      right: 55,
                    ),
                    child: Container(
                      color: Colors.transparent,
                      width:
                          ((screenWidth - 500) - (screenWidth * (1 / 5)) - 55),
                      height: 600,
                      child: GridView.count(
                        children: [
                          webSquare("🎨", "Customize", "Theme", context),
                          webSquare("📕", "Tailor Your", "Menu", context),
                          webSquare("🔎", "Write Your", "About Us", context),
                          webSquare("📸", "Add Your", "Image", context),
                          webSquare("📍", "Add Your", "Locations", context),
                          webSquare("⚙", "Open", "Settings", context),
                        ],
                        crossAxisCount: 3,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 60,
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 27,
                              left: 25,
                            ),
                            child: Container(
                              width: double.infinity,
                              child: CustomText(
                                text: "Analytics",
                                fontWeight: FontWeight.bold,
                                align: TextAlign.left,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: isLight ? navy500 : navy400,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      width: 332,
                      height: 455,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: isLight ? backgroundLight : backgroundDark,
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  square("🎨", "Customize", "Theme", context),
                  square("📕", "Tailor Your", "Menu", context),
                  rectangle("Write Your", "About Us", context, false),
                ],
              ),
              Column(
                children: [
                  rectangle("Total Users", "${users}", context, true),
                  square("📸", "Add Your", "Image", context),
                  square("📍", "Add Your", "Locations", context),
                ],
              ),
            ],
          ),
        ),
      );
    }
    // Scaffold(
    //   body: Column(
    //     children: [
    //       SizedBox(
    //         height: 200,
    //       ),
    //       CustomText(
    //         text: "Home Page",
    //         fontWeight: FontWeight.bold,
    //       ),
    //       SizedBox(
    //         height: 50,
    //       ),
    //       CustomText(
    //         text: "Welcome User: ${FirebaseAuth.instance.currentUser?.uid}",
    //       ),
    //       SizedBox(
    //         height: 20,
    //       ),
    //       Padding(
    //         padding: EdgeInsets.fromLTRB(25, 25, 25, 25),
    //         child: MainButton(
    //           text: "Sign Out",
    //           function: () async {
    //             await FirebaseAuth.instance.signOut();
    //             HapticFeedback.mediumImpact();
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    //   backgroundColor: isLight ? backgroundLight : backgroundDark,
    // );
  }
}
