import 'package:dish_connect/helpers/get_width.dart';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/widgets/button.dart';
import 'package:dish_connect/widgets/main_button.dart';
import 'package:dish_connect/widgets/menu/cat_container.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

int selectedIndex = 0;

class CategoryRow extends StatefulWidget {
  const CategoryRow({Key? key}) : super(key: key);

  @override
  State<CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  @override
  Widget build(BuildContext context) {
    var isSmall = MediaQuery.of(context).size.width < 1210;
    return Container(
      child: isSmall ? SmallCatRow() : BigCatRow(),
    );
  }
}

class SmallCatRow extends StatefulWidget {
  const SmallCatRow({Key? key}) : super(key: key);

  @override
  State<SmallCatRow> createState() => _SmallCatRowState();
}

class _SmallCatRowState extends State<SmallCatRow> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BigCatRow extends StatefulWidget {
  const BigCatRow({Key? key}) : super(key: key);

  @override
  State<BigCatRow> createState() => _BigCatRowState();
}

class _BigCatRowState extends State<BigCatRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 500,
      color: Colors.yellow,
    );
    // FirebaseAnimatedList(
    //   scrollDirection: Axis.horizontal,
    //   query: menuCategoryRef,
    //   padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
    //   itemBuilder: (
    //     BuildContext context,
    //     DataSnapshot snapshot,
    //     Animation<double> animation,
    //     int index,
    //   ) {
    //     var value = Map<String, dynamic>.from(snapshot.value as Map);
    //     var title = value["name"];
    //     return GestureDetector(
    //       onTap: () {
    //         setState(() {
    //           selectedIndex = index;
    //         });
    //       },
    //       child: Container(
    //         height: 20,
    //         child: categoryContainer(
    //           title,
    //           "hello",
    //           index,
    //           context,
    //         ),
    //         width: getWidth(title, context) + 50,
    //       ),
    //     );
    //   },
    // );
    // return Container(
    //   height: 45,
    //   child: Row(
    //     children: [
    //       Container(
    //         height: 44,
    //         width: 120,
    //         child: MainButton(
    //           text: "Edit Category",
    //           textSize: 12.0,
    //         ),
    //       ),
    //       SizedBox(
    //         width: 17,
    //       ),
    //       Container(
    //         height: 44,
    //         width: 140,
    //         child: MainButton(
    //           buttonColor: Colors.red,
    //           text: "Delete Category",
    //           textSize: 12.0,
    //         ),
    //       ),
    //     ],
    //     mainAxisAlignment: MainAxisAlignment.end,
    //   ),
    // );
  }
}
