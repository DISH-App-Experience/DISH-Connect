import 'dart:io';
import 'package:dish_connect/widgets/custom_cancel_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../constants/colors.dart';
import '../../../helpers/global_variables.dart';
import '../../../services/web_work.dart';
import '../../../widgets/button.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/main_textfield.dart';
import '../../../widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class NewLocationPopup extends StatefulWidget {
  const NewLocationPopup({
    Key? key,
  }) : super(key: key);

  @override
  State<NewLocationPopup> createState() => _NewLocationPopupState();
}

class _NewLocationPopupState extends State<NewLocationPopup> {
  bool loading = false;
  final newKey = locationRef.push().key;
  Future _uploadFile(String path) async {
    String filePath = "";
    final FirebaseStorage _storage = FirebaseStorage.instance;
    if (isNew) {
      filePath = "App/${owner!.appId}/locations/${newKey}";
    } else {
      filePath = "App/${owner!.appId}/locations/${newKey}";
    }
    final result = await _storage.ref(filePath).putFile(File(path));
    final fileUrl = await _storage.ref(filePath).getDownloadURL();
    locationRef.child(newKey!).child("image").set(fileUrl);
    print("DONE SUCCESS!");
    print(fileUrl);
    setState(() {
      downloadURL = fileUrl;
      loading = true;
    });
  }

  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  String downloadURL = "";
  bool isNew = false;
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    String imageName;
    String title;
    bool imageNull;
    isNew = true;
    imageName = "Add Image";
    title = "Add Location";
    zipcodeController.text = "";
    imageNull = true;

    void updateLocation(
      bool isNew,
    ) async {
      EasyLoading.show(status: "Saving...");
      var city = cityController.text;
      var state = stateController.text;
      var street = streetController.text;
      var zipcode = zipcodeController.text;

      if ((city != "") && (state != "") && (street != "") && (zipcode != "")) {
        print("city: ${city}");
        print("state: ${state}");
        print("street: ${street}");
        print("zipcode: ${zipcode}");
        if (isNew) {
          if (downloadURL != "") {
            final postData = {
              'city': city,
              'image': downloadURL,
              'state': state,
              'street': street,
              'uid': newKey,
              'zip': int.parse(zipcode),
            };
            locationRef.child(newKey!).update(postData);
          }
        } else {
          print("user has wrong poup");
        }
        EasyLoading.showSuccess("Success");
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError("Please make sure all fields are filled in!");
      }
    }

    return Container(
      child: Center(
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
                      child: downloadURL == ""
                          ? Container()
                          : ClipRRect(
                              child: Image.network(
                                downloadURL,
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
                        onTap: () async {
                          String? imageUrl = await urlFromWebImage();
                          print(imageUrl);
                          setState(() {
                            loading = true;
                            downloadURL = imageUrl!;
                          });
                        },
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
                            keyboardType: TextInputType.number,
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
                                      locationRef.child(newKey!).remove();
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
      ),
    );
  }
}
