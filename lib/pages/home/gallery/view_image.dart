import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/widgets/custom_back_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

class ViewGalleryImageView extends StatefulWidget {
  const ViewGalleryImageView({Key? key}) : super(key: key);

  @override
  State<ViewGalleryImageView> createState() => _ViewGalleryImageViewState();
}

class _ViewGalleryImageViewState extends State<ViewGalleryImageView> {
  var imageUrl = "";
  dynamic argumentData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          CustomBackButton(),
          Expanded(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 300,
                  width: 300,
                  color: mainBlue,
                  child: Container(
                    child: Image.network(
                      "${argumentData[0]["gallery-image-url"]}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              child: Center(
                child: Text(
                  "Delete Image",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              onTap: () {
                showCupertinoDialog<void>(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: const Text('Delete Image'),
                    content: const Text('You can undo this action!'),
                    actions: <CupertinoDialogAction>[
                      CupertinoDialogAction(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text('Yes, Delete'),
                        onPressed: () {
                          FirebaseDatabase.instance
                              .ref()
                              .child("Apps")
                              .child(owner!.appId)
                              .child("photos")
                              .child(argumentData[0]["gallery-image-key"])
                              .remove();
                          Get.back();
                        },
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
