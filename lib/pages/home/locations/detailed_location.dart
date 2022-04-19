import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/widgets/button.dart';
import 'package:dish_connect/widgets/custom_back_button.dart';
import 'package:dish_connect/widgets/main_button.dart';
import 'package:dish_connect/widgets/main_textfield.dart';
import 'package:dish_connect/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationDetailedView extends StatefulWidget {
  const LocationDetailedView({Key? key}) : super(key: key);

  @override
  State<LocationDetailedView> createState() => _LocationDetailedViewState();
}

class _LocationDetailedViewState extends State<LocationDetailedView> {
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var isSmall = MediaQuery.of(context).size.width < 1210;
    dynamic argumentData = Get.arguments;
    String locationType = argumentData[0]["location-type"];
    String imageType;
    if (locationType == "View") {
      imageType = "Change Image";
    } else {
      imageType = "Add Image";
    }
    return Scaffold(
      backgroundColor: isLight ? Colors.white : navy500,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 75,
            ),
            Stack(
              children: [
                CustomBackButton(),
                Center(
                  child: smallNavigationBar(
                    context,
                    "${locationType} Location",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: isLight ? blue100 : Colors.black,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Button(name: imageType),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 25,
                right: 25,
              ),
              child: MainTextField(
                hintText: "Street Name",
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    left: 25,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 220,
                    child: MainTextField(
                      hintText: "City",
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    right: 25,
                  ),
                  child: Container(
                    width: 150,
                    child: MainTextField(
                      hintText: "Zipcode",
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 15,
                left: 25,
                right: 25,
              ),
              child: MainTextField(
                hintText: "State",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 25,
                left: 25,
                right: 25,
              ),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  child: MainButton(
                    text: "Save",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Button(
                name: "Remove Location",
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
