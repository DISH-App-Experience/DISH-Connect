import 'dart:io';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/models/location.dart';
import 'package:dish_connect/pages/home/locations/detailed_location.dart';
import 'package:dish_connect/widgets/button.dart';
import 'package:dish_connect/widgets/custom_cancel_button.dart';
import 'package:dish_connect/widgets/main_button.dart';
import 'package:dish_connect/widgets/main_textfield.dart';
import 'package:dish_connect/widgets/navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/widgets/custom_back_button.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:geocode/geocode.dart';
import 'package:image_picker/image_picker.dart';

class LocationManagerPage extends StatefulWidget {
  const LocationManagerPage({Key? key}) : super(key: key);

  @override
  State<LocationManagerPage> createState() => _LocationManagerPageState();
}

class _LocationManagerPageState extends State<LocationManagerPage> {
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  FirebaseStorage storage = FirebaseStorage.instance;
  GeoCode geoCode = GeoCode();

  void updateLocation(
    bool isNew,
    String uid,
  ) async {
    EasyLoading.show(status: "Saving...");
    var city = cityController.text;
    var state = stateController.text;
    var street = streetController.text;
    var zipcode = zipcodeController.text;

    if ((city != "") && (state != "") && (street != "") && (zipcode != "")) {
      try {
        Coordinates coordinates = await geoCode.forwardGeocoding(
            address: "${street}, ${city}, ${state} ${zipcode}");
        print("lat: ${coordinates.latitude}");
        print("long: ${coordinates.longitude}");
        var lat = coordinates.latitude;
        var long = coordinates.longitude;
        print("city: ${city}");
        print("state: ${state}");
        print("street: ${street}");
        print("zipcode: ${zipcode}");
        if (isNew) {
          final key = locationRef.push().key;
          final postData = {
            'city': city,
            // 'image': uid,
            'lat': lat,
            'long': long,
            'state': state,
            'street': street,
            'uid': key,
            'zip': int.parse(zipcode),
          };
          locationRef.child(key!).update(postData);
        } else {
          final key = uid;
          final postData = {
            'city': city,
            // 'image': uid,
            'lat': lat,
            'long': long,
            'state': state,
            'street': street,
            'uid': key,
            'zip': int.parse(zipcode),
          };
          locationRef.child(key).update(postData);
        }
        EasyLoading.showSuccess("Success");
      } catch (e) {
        EasyLoading.dismiss();
        EasyLoading.showError("Error: ${e}");
      }
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError("Please make sure all fields are filled in!");
    }
  }

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
              true,
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
                      final cur = Map<String, dynamic>.from(value);
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
                                  false,
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isLight ? blue100 : Colors.black,
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              ),
                              child: Container(
                                height: 200,
                                width: 200,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                              10,
                                            ),
                                            topRight: Radius.circular(
                                              10,
                                            ),
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                locations[index].image),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(8.0),
                                      height: isSmall ? 44 : 67,
                                      decoration: BoxDecoration(
                                        color: isLight
                                            ? Color(0xFFF2F2F2)
                                            : Colors.black,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0),
                                        ),
                                      ),
                                      child: CustomText(
                                        text: locations[index].street,
                                        size: isSmall ? 12 : 15,
                                        fontWeight: FontWeight.bold,
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
    bool imageNull;
    if (isNew) {
      imageName = "Add Image";
      title = "Add Location";
    } else {
      imageName = "Change Image";
      title = "Edit Location";
    }
    streetController.text = street;
    cityController.text = city;
    zipcodeController.text = "${zipcode}";
    stateController.text = state;
    if (image != "") {
      imageNull = false;
    } else {
      imageNull = true;
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
                        CustomCancelButton(),
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
                        child: imageNull
                            ? Container()
                            : ClipRRect(
                                child: Image.network(
                                  image,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20),
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
                        controller: streetController,
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
                              controller: cityController,
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
                              controller: zipcodeController,
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
                        controller: stateController,
                        hintText: "State",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 25,
                        left: 25,
                        right: 25,
                      ),
                      child: GestureDetector(
                        child: MainButton(
                          text: "Save",
                          function: () {
                            updateLocation(
                              isNew,
                              isNew ? "" : uid,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    if (!isNew)
                      Center(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              showCupertinoDialog<void>(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoAlertDialog(
                                  title: const Text('Wait!'),
                                  content: const Text(
                                    'Are you sure you want to delete this location?',
                                  ),
                                  actions: <CupertinoDialogAction>[
                                    CupertinoDialogAction(
                                      child: const Text('No, cancel'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: const Text('Yes'),
                                      isDestructiveAction: true,
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        locationRef.child(uid).remove();
                                      },
                                    )
                                  ],
                                ),
                              );
                            },
                            child: Button(
                              name: "Delete Location",
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
