import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/models/location.dart';
import 'package:dish_connect/pages/home/locations/detailed_location.dart';
import 'package:dish_connect/widgets/button.dart';
import 'package:dish_connect/widgets/main_button.dart';
import 'package:dish_connect/widgets/main_textfield.dart';
import 'package:dish_connect/widgets/navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/widgets/custom_back_button.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:get/get.dart';

class LocationManagerPage extends StatefulWidget {
  const LocationManagerPage({Key? key}) : super(key: key);

  @override
  State<LocationManagerPage> createState() => _LocationManagerPageState();
}

class _LocationManagerPageState extends State<LocationManagerPage> {
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var isSmall = MediaQuery.of(context).size.width < 1210;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          if (isSmall) {
            Get.to(
              LocationDetailedView(),
              arguments: [
                {
                  "location-key": "",
                  "location-type": "Add",
                  "location-image": "",
                  "location-street": "",
                  "location-city": "",
                  "location-zipcode": "",
                  "location-state": "",
                },
              ],
            );
          } else {
            showLocationPopup(
              context,
              "",
              "",
              "",
              "",
              0,
              "",
              false,
            );
          }
        },
        backgroundColor: mainBlue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: isLight ? Colors.white : navy500,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackButton(),
            navigationBar(
              context,
              "Locations",
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 42,
                left: 25,
                right: 25,
              ),
              child: StreamBuilder(
                stream: locationRef.onValue,
                builder: (context, snapshot) {
                  List<Location> locations = [];
                  if (snapshot.hasData && !snapshot.hasError) {
                    final myImages = Map<dynamic, dynamic>.from(
                        (snapshot.data! as DatabaseEvent).snapshot.value
                            as Map<dynamic, dynamic>);
                    myImages.forEach((key, value) {
                      print("fioudn location");
                      final cur = Map<String, dynamic>.from(value);
                      print("city");
                      print(cur["city"]);
                      locations.add(
                        Location(
                          cur["city"],
                          cur["image"],
                          cur["lat"],
                          cur["long"],
                          cur["state"],
                          cur["street"],
                          cur["uid"],
                          cur["zip"],
                        ),
                      );
                    });
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: locations.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isSmall ? 2 : 4,
                        mainAxisSpacing: isSmall ? 12.5 : 37,
                        crossAxisSpacing: isSmall ? 12.5 : 37,
                      ),
                      itemBuilder: (context, index) {
                        Location location = locations[index];
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              if (isSmall) {
                                Get.to(
                                  LocationDetailedView(),
                                  arguments: [
                                    {
                                      "location-key": location.uid,
                                      "location-type": "View",
                                      "location-image": location.image,
                                      "location-street": location.street,
                                      "location-city": location.city,
                                      "location-zipcode": location.zipcode,
                                      "location-state": location.state,
                                    },
                                  ],
                                );
                              } else {
                                showLocationPopup(
                                  context,
                                  location.uid,
                                  location.image,
                                  location.street,
                                  location.city,
                                  location.zipcode,
                                  location.state,
                                  true,
                                );
                              }
                            },
                            child: Container(
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: isLight ? blue100 : Colors.black,
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    child: Expanded(
                                      child: ClipRRect(
                                        child: Image.network(
                                          location.image,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: isLight
                                                ? blue100
                                                : Colors.black,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(
                                                20,
                                              ),
                                              bottomRight: Radius.circular(
                                                20,
                                              ),
                                            ),
                                          ),
                                          height: isSmall ? 44 : 67,
                                          child: Center(
                                            child: CustomText(
                                              text: locations[index].street,
                                              size: isSmall ? 12 : 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  showLocationPopup(
    BuildContext context,
    String uid,
    String image,
    String street,
    String city,
    int zipcode,
    String state,
    bool isNew,
  ) {
    String imageName;
    String title;
    if (isNew) {
      imageName = "Add Image";
      title = "Add Location";
    } else {
      imageName = "Change Image";
      title = "Edit Location";
    }
    return showDialog(
      context: context,
      builder: (context) {
        var isLight = Theme.of(context).brightness == Brightness.light;
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              width: 427,
              height: 676,
              decoration: BoxDecoration(
                color: isLight ? Colors.white : navy500,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      children: [
                        CustomBackButton(),
                        Center(
                          child: smallNavigationBar(
                            context,
                            title,
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
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          child: Button(
                            name: imageName,
                          ),
                        ),
                      ),
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
                            width: 427 - 220,
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
                    if (isNew)
                      Center(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              print("remove");
                            },
                            child: Button(
                              name: "Remove Location",
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
