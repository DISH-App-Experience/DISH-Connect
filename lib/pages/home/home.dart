import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/constants/controllers.dart';
import 'package:dish_connect/controllers/navigation_controller.dart';
import 'package:dish_connect/helpers/colors.dart';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/helpers/responsiveness.dart';
import 'package:dish_connect/models/theme.dart';
import 'package:dish_connect/pages/home/about/about_us.dart';
import 'package:dish_connect/pages/home/theme/customize_theme.dart';
import 'package:dish_connect/routing/routes.dart';
import 'package:dish_connect/services/image_services.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:dish_connect/routing/router.dart';
import 'package:dish_connect/widgets/home/analytics_item.dart';
import 'package:dish_connect/widgets/home/home_square.dart';
import 'package:dish_connect/widgets/main_button.dart';
import 'package:dish_connect/widgets/main_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:get/get.dart';

import '../../widgets/home/home_square_web.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var users = 0;
  var appSessions = 0;
  var reservationsBooked = 0;
  var ordersPlaced = 0;
  var calledRestaurants = 0;
  var openedMenus = 0;

  double males = 0;
  double females = 0;

  late final dataMap = <String, double>{
    "Male": males,
    "Female": females,
  };

  final colorList = <Color>[
    Color(0xffEC5858),
    Color(0xff1CB0F6),
  ];

  ChartType? _chartType = ChartType.disc;
  bool _showCenterText = true;
  double? _ringStrokeWidth = 32;
  double? _chartLegendSpacing = 32;
  bool _showLegendsInRow = true;
  bool _showLegends = true;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = true;
  bool _showChartValuesOutside = false;

  bool _showGradientColors = false;

  BoxShape? _legendShape = BoxShape.circle;
  LegendPosition? _legendPosition = LegendPosition.bottom;

  int key = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAnalytics();
  }

  void getAnalytics() {
    findUsers();
    findData("appSessions");
    findData("reservationsBooked");
    findData("ordersPlaced");
    findData("calledRestaurants");
    findData("openedMenus");
  }

  void findUsers() {
    FirebaseDatabase.instance
        .ref()
        .child("Apps")
        .child(owner!.appId)
        .child("Users")
        .onValue
        .listen((event) {
      for (final child in event.snapshot.children) {
        var childValue = Map<String, dynamic>.from(child.value as Map);
        var gender = childValue["gender"] ?? "Male";
        switch (gender) {
          case "Male":
            print("we got a male!");
            setState(() {
              males++;
            });
            break;
          case "Female":
            print("we got a female!");
            setState(() {
              females++;
            });
            break;
        }
        setState(() {
          users++;
        });
      }
    });
  }

  void findData(String analytic) {
    FirebaseDatabase.instance
        .ref()
        .child("Analytics")
        .child(analytic)
        .onValue
        .listen((event) {
      for (final child in event.snapshot.children) {
        var childValue = Map<String, dynamic>.from(child.value as Map);
        var id = childValue["restaurantId"];
        if (id == owner!.appId) {
          switch (analytic) {
            case "appSessions":
              setState(() {
                appSessions++;
              });
              break;
            case "reservationsBooked":
              setState(() {
                reservationsBooked++;
              });
              break;
            case "ordersPlaced":
              setState(() {
                ordersPlaced++;
              });
              break;
            case "calledRestaurants":
              setState(() {
                calledRestaurants++;
              });
              break;
            case "openedMenus":
              setState(() {
                openedMenus++;
              });
              break;
          }
        }
      }
    });
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
        switch (mainHeader) {
          case "Theme":
            navigationController.navigateTo(CustomizeThemePageRoute);
            break;
          case "Menu":
            var item = MenuItem(MenuPageRouteDisplayName, MenuPageRoute);
            menuController.changeActiveItemTo(item.name);
            navigationController.navigateTo(MenuPageRoute);
            break;
          case "About Us":
            navigationController.navigateTo(AboutUsPageRoute);
            break;
          case "Images":
            navigationController.navigateTo(GalleryPageRoute);
            break;
          case "Locations":
            navigationController.navigateTo(LocationPageRoute);
            break;
          case "Settings":
            navigationController.navigateTo(SettingsPageRoute);
            break;
        }
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
                      height: ((MediaQuery.of(context).size.width - 75) / 2),
                      child: GridView.count(
                        children: [
                          webSquare("🎨", "Customize", "Theme", context),
                          webSquare("📕", "Tailor Your", "Menu", context),
                          webSquare("🔎", "Write Your", "About Us", context),
                          webSquare("📸", "Add Your", "Images", context),
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
                                color: isLight ? Colors.white : Colors.white,
                              ),
                            ),
                          ),
                          analyticItem("Total Users:", users, true),
                          analyticItem(
                              "Total App Sessions:", appSessions, false),
                          analyticItem("Reservations Booked:",
                              reservationsBooked, false),
                          analyticItem("Orders Placed:", ordersPlaced, false),
                          analyticItem("Calls using Restaurant App:",
                              calledRestaurants, false),
                          analyticItem("Opened Menus:", openedMenus, false),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 25,
                              left: 25,
                              right: 25,
                            ),
                            child: PieChart(
                              key: ValueKey(key),
                              dataMap: dataMap,
                              animationDuration: Duration(milliseconds: 800),
                              chartLegendSpacing: _chartLegendSpacing!,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2 > 300
                                      ? 300
                                      : MediaQuery.of(context).size.width / 3.2,
                              colorList: colorList,
                              initialAngleInDegree: 0,
                              chartType: _chartType!,
                              centerText: _showCenterText
                                  ? "User Gender Demographic"
                                  : null,
                              legendOptions: LegendOptions(
                                showLegendsInRow: _showLegendsInRow,
                                legendPosition: _legendPosition!,
                                showLegends: _showLegends,
                                legendShape: _legendShape == BoxShape.circle
                                    ? BoxShape.circle
                                    : BoxShape.rectangle,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              chartValuesOptions: ChartValuesOptions(
                                showChartValueBackground:
                                    _showChartValueBackground,
                                showChartValues: _showChartValues,
                                showChartValuesInPercentage:
                                    _showChartValuesInPercentage,
                                showChartValuesOutside: _showChartValuesOutside,
                              ),
                              ringStrokeWidth: _ringStrokeWidth!,
                              emptyColor: Colors.transparent,
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
                      height: 650,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
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
                  square("📸", "Add Your", "Images", context),
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
