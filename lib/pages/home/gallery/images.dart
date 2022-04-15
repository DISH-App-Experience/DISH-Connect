import 'dart:async';
import 'dart:io';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/models/image.dart';
import 'package:dish_connect/pages/home/gallery/view_image.dart';
import 'package:dish_connect/pages/home/gallery/web_images.dart';
import 'package:dish_connect/routing/routes.dart';
import 'package:dish_connect/services/image_services.dart';
import 'package:dish_connect/services/web_work.dart';
import 'package:dish_connect/widgets/navigation_bar.dart';
import 'package:dish_connect/widgets/theme/crop_util.dart';
import 'package:dish_connect/widgets/top_nav.dart';
import 'package:file_picker/file_picker.dart';
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
import 'package:image_picker/image_picker.dart';

class ImageGallery extends StatefulWidget {
  const ImageGallery({Key? key}) : super(key: key);

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  List<ImageGalleryObject>? images;
  FirebaseStorage storage = FirebaseStorage.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future pickImage() async {
    print("picking image");
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print("passed null");
      final imageTemp = File(image.path);
      uploadImageToFirebase(imageTemp);
    }
  }

  Future uploadImageToFirebase(File imageTemp) async {
    EasyLoading.show(status: "Uploading Image");
    final newPostKey = FirebaseDatabase.instance
        .ref()
        .child("App")
        .child(owner!.appId)
        .child("photos")
        .push()
        .key;
    try {
      final ref = storage
          .ref()
          .child("App")
          .child(owner!.appId)
          .child("photos")
          .child(newPostKey!);
      await ref.putFile(imageTemp);
      String downloadURL = await FirebaseStorage.instance
          .ref('App/${owner!.appId}/photos/${newPostKey}')
          .getDownloadURL();
      final postData = {
        'url': downloadURL,
        'key': newPostKey,
      };
      FirebaseDatabase.instance
          .ref()
          .child("Apps")
          .child(owner!.appId)
          .child("photos")
          .child(newPostKey)
          .set(postData);
      EasyLoading.showSuccess("Success!");
    } catch (e) {
      EasyLoading.showError("Error: ${e.toString()}}");
      print('error occured');
    }
  }

  showImagePopup(
    BuildContext context,
    String imageURL,
    String key,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        var isLight = Theme.of(context).brightness == Brightness.light;
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              width: 427,
              height: 457,
              decoration: BoxDecoration(
                color: isLight ? Colors.white : navy500,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 64,
                      top: 64,
                      right: 64,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 299,
                        child: Image.network(
                          imageURL,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        FirebaseDatabase.instance
                            .ref()
                            .child("Apps")
                            .child(owner!.appId)
                            .child("photos")
                            .child(key)
                            .remove();
                        Navigator.pop(context);
                      },
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var isSmall = MediaQuery.of(context).size.width < 1210;
    return Scaffold(
      backgroundColor: isLight ? Colors.white : navy500,
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainBlue,
        elevation: 0,
        onPressed: () async {
          if (kIsWeb) {
            uploadToStorage();
          } else {
            pickImage();
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackButton(),
            navigationBar(
              context,
              "Images",
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 42,
                left: 25,
                right: 25,
              ),
              child: StreamBuilder(
                stream: photosRef.onValue,
                builder: (context, snapshot) {
                  List<ImageGalleryObject> images = [];
                  if (snapshot.hasData && !snapshot.hasError) {
                    final myImages = Map<dynamic, dynamic>.from(
                        (snapshot.data! as DatabaseEvent).snapshot.value
                            as Map<dynamic, dynamic>);
                    myImages.forEach((key, value) {
                      final currentImage = Map<String, dynamic>.from(value);
                      images.add(
                        ImageGalleryObject(
                          key: currentImage["key"],
                          url: currentImage["url"],
                        ),
                      );
                    });
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: images.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isSmall ? 2 : 6,
                        mainAxisSpacing: isSmall ? 12.5 : 37,
                        crossAxisSpacing: isSmall ? 12.5 : 37,
                      ),
                      itemBuilder: (context, index) {
                        ImageGalleryObject image = images[index];
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              if (isSmall) {
                                Get.to(
                                  ViewGalleryImageView(),
                                  arguments: [
                                    {
                                      "gallery-image-key": image.key,
                                      "gallery-image-url": image.url,
                                    },
                                  ],
                                );
                              } else {
                                showImagePopup(
                                  context,
                                  image.url,
                                  image.key,
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
                              height: 200,
                              width: 200,
                              child: ClipRRect(
                                child: Image.network(
                                  image.url,
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(20),
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

  showDialogFunc(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(),
        );
      },
    );
  }
}
