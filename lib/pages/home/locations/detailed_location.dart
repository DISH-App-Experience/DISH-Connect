import 'dart:io';
import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/widgets/button.dart';
import 'package:dish_connect/widgets/custom_back_button.dart';
import 'package:dish_connect/widgets/main_button.dart';
import 'package:dish_connect/widgets/main_textfield.dart';
import 'package:dish_connect/widgets/navigation_bar.dart';
import 'package:dish_connect/widgets/theme/crop_util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class LocationDetailedView extends StatefulWidget {
  const LocationDetailedView({Key? key}) : super(key: key);

  @override
  State<LocationDetailedView> createState() => _LocationDetailedViewState();
}

class _LocationDetailedViewState extends State<LocationDetailedView> {
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  FirebaseStorage storage = FirebaseStorage.instance;
  GeoCode geoCode = GeoCode();

  bool isNew = false;
  String downloadURL = "";
  dynamic argumentData = Get.arguments;

  XFile? _imageFile;
  final newKey = locationRef.push().key;
  UploadTask? _uploadTask;

  void pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      print("finding picked file is an error");
      return;
    }
    var file = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      iosUiSettings: iosUiSettingsLocked(),
      androidUiSettings: androidUiSettingsLocked(),
    );
    if (file == null) {
      print("finding new file is an error");
      return;
    }

    await _uploadFile(file.path);
  }

  Future _uploadFile(String path) async {
    String filePath = "";
    final FirebaseStorage _storage = FirebaseStorage.instance;
    if (isNew) {
      filePath = "App/${owner!.appId}/locations/${newKey}";
    } else {
      filePath =
          "App/${owner!.appId}/locations/${argumentData[0]["location-key"]}";
    }
    final result = await _storage.ref(filePath).putFile(File(path));
    final fileUrl = await _storage.ref(filePath).getDownloadURL();
    print("DONE SUCCESS!");
    print(fileUrl);
    setState(() {
      downloadURL = fileUrl;
    });
  }

  IOSUiSettings iosUiSettingsLocked() => IOSUiSettings(
        rotateClockwiseButtonHidden: false,
        rotateButtonsHidden: false,
      );

  AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: mainBlue,
        toolbarWidgetColor: Colors.white,
        hideBottomControls: true,
      );

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
        print("download url: ${downloadURL}");

        if (isNew) {
          if (downloadURL != "") {
            final key = locationRef.push().key;
            final postData = {
              'city': city,
              'image': downloadURL,
              'lat': lat,
              'long': long,
              'state': state,
              'street': street,
              'uid': key,
              'zip': int.parse(zipcode),
            };
            locationRef.child(key!).update(postData);
            EasyLoading.showSuccess("Success!!");
          } else {
            EasyLoading.dismiss();
            EasyLoading.showError("Error, please select an image");
          }
        } else {
          if (downloadURL != "") {
            final key = uid;
            final postData = {
              'city': city,
              'image': downloadURL,
              'lat': lat,
              'long': long,
              'state': state,
              'street': street,
              'uid': key,
              'zip': int.parse(zipcode),
            };
            locationRef.child(key).update(postData);
          } else {
            final key = uid;
            final postData = {
              'city': city,
              'lat': lat,
              'long': long,
              'state': state,
              'street': street,
              'uid': key,
              'zip': int.parse(zipcode),
            };
            locationRef.child(key).update(postData);
          }
        }
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
    String locationType = argumentData[0]["location-type"];
    String imageType;
    String uid = argumentData[0]["location-key"];
    if (!isNew) {
      downloadURL = argumentData[0]["location-image"];
    }
    if (locationType == "View") {
      imageType = "Change Image";
      setState(() {
        isNew = false;
      });
      String street = argumentData[0]["location-street"];
      String city = argumentData[0]["location-city"];
      int zipcode = argumentData[0]["location-zipcode"];
      String state = argumentData[0]["location-state"];
      streetController.text = street;
      cityController.text = city;
      zipcodeController.text = "${zipcode}";
      stateController.text = state;
    } else {
      imageType = "Add Image";
      setState(() {
        isNew = true;
      });
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
                child: !downloadURL.isEmpty
                    ? ClipRRect(
                        child: Image.network(
                          downloadURL,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      )
                    : Container(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Button(
                name: imageType,
                function: () {
                  if (kIsWeb) {
                    print("web");
                  } else {
                    print("mobile");
                    pickImage();
                  }
                },
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
                    width: MediaQuery.of(context).size.width - 220,
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
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    updateLocation(
                      isNew,
                      isNew ? "" : uid,
                    );
                  },
                  child: MainButton(
                    text: "Save",
                  ),
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
                        builder: (BuildContext context) => CupertinoAlertDialog(
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
    );
  }
}
