import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/helpers/get_width.dart';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/models/menu_item.dart';
import 'package:dish_connect/pages/menu/category_row.dart';
import 'package:dish_connect/services/firebase_api.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:dish_connect/widgets/menu/cat_container.dart';
import 'package:dish_connect/widgets/navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => MenuPageState();
}

var menuCategories = FirebaseApi().getCategories();
var menuItems = FirebaseApi().getMenuItems();

class MenuPageState extends State<MenuPage> {
  var shouldBeShown = List<MenuItem>;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var isSmall = MediaQuery.of(context).size.width < 1210;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          if (isSmall) {
            //
          } else {
            //
          }
        },
        backgroundColor: mainBlue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: isLight ? backgroundLight : backgroundDark,
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
                    "Menu",
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      left: 55,
                    ),
                    child: Container(
                      width: double.infinity,
                      child: CustomText(
                        text: "Menu",
                        fontWeight: FontWeight.bold,
                        align: TextAlign.left,
                        size: 50,
                      ),
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: FirebaseAnimatedList(
                scrollDirection: Axis.horizontal,
                query: menuCategoryRef,
                padding: EdgeInsets.fromLTRB(
                    isSmall ? 25 : 55, 0, isSmall ? 25 : 55, 0),
                itemBuilder: (
                  BuildContext context,
                  DataSnapshot snapshot,
                  Animation<double> animation,
                  int index,
                ) {
                  var value = Map<String, dynamic>.from(snapshot.value as Map);
                  var title = value["name"];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      height: 20,
                      child: categoryContainer(
                        title,
                        value["key"],
                        index,
                        context,
                      ),
                      width: getWidth(
                            title,
                            context,
                          ) +
                          50,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
