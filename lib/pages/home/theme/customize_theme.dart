import 'dart:io';
import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/helpers/colors.dart';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/models/theme.dart';
import 'package:dish_connect/services/firebase_api.dart';
import 'package:dish_connect/widgets/custom_back_button.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:dish_connect/widgets/cyclop/cyclop.dart';
import 'package:dish_connect/widgets/cyclop/src/widgets/color_button.dart';
import 'package:dish_connect/widgets/cyclop/src/widgets/eyedrop/eye_dropper_layer.dart';
import 'package:dish_connect/widgets/navigation_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:path/path.dart';

AppTheme? appTheme;

class CustomizeThemePage extends StatefulWidget {
  const CustomizeThemePage({Key? key}) : super(key: key);

  @override
  State<CustomizeThemePage> createState() => _CustomizeThemePageState();
}

class _CustomizeThemePageState extends State<CustomizeThemePage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  File? image;
  File? file;
  String? downloadURL;

  Color? backgroundColor;
  Color? textColor;
  Color? themeColor;
  Color? secondaryBackground;
  Color? textOnTheme;

  @override
  void initState() {
    super.initState();

    EasyLoading.show(status: "Loading");
    findDownloadURL();
    themeRef.child("backgroundColor").once().then((backEvent) {
      String background = (backEvent.snapshot.value as String).toUpperCase();
      Color backgroundColor = hexOrRGBToColor(background);
      themeRef.child("secondaryBackground").once().then((secEvent) {
        String secCol = (secEvent.snapshot.value as String).toUpperCase();
        Color secondaryColor = hexOrRGBToColor(secCol);
        themeRef.child("textColor").once().then((textCol) {
          String text = (textCol.snapshot.value as String).toUpperCase();
          Color textColor = hexOrRGBToColor(text);
          themeRef.child("themeColor").once().then((themeEvent) {
            String theme = (themeEvent.snapshot.value as String).toUpperCase();
            Color themeColor = hexOrRGBToColor(theme);
            themeRef.child("themeColorOnButton").once().then((themeOnEvent) {
              String themeOnVal =
                  (themeOnEvent.snapshot.value as String).toUpperCase();
              Color themeColorOnButton = hexOrRGBToColor(themeOnVal);
              setState(() {
                this.backgroundColor = backgroundColor;
                this.textColor = textColor;
                this.themeColor = themeColor;
                this.secondaryBackground = secondaryColor;
                this.textOnTheme = themeColorOnButton;
              });
              EasyLoading.dismiss();
            });
          });
        });
      });
    });
  }

  Widget colorRow(BuildContext context, String title, String id, Color color) {
    Color myColor = color;
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      height: 85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          CustomText(
            text: title,
            size: 12,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 160,
                decoration: BoxDecoration(
                  color: myColor,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  border: Border(
                    top: BorderSide(
                      color: isLight ? backgroundDark : backgroundLight,
                      width: 1,
                    ),
                    right: BorderSide(
                      color: isLight ? backgroundDark : backgroundLight,
                      width: 1,
                    ),
                    left: BorderSide(
                      color: isLight ? backgroundDark : backgroundLight,
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: isLight ? backgroundDark : backgroundLight,
                      width: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    print("hi there");
                  },
                  child: ColorButton(
                    key: Key('c1'),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: mainBlue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 100,
                      height: 40,
                      child: Stack(
                        children: [
                          Container(
                            child: Center(
                              child: CustomText(
                                color: mainBlue,
                                size: 12,
                                text: "Change",
                                fontWeight: FontWeight.bold,
                                align: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    color: Colors.transparent,
                    config: ColorPickerConfig(
                      enableEyePicker: true,
                      enableLibrary: true,
                      enableOpacity: false,
                    ),
                    boxShape: BoxShape.rectangle, // default : circle
                    size: 32,
                    onColorChanged: (value) {
                      print('hi there');
                      switch (id) {
                        case "backgroundColor":
                          setState(() {
                            this.backgroundColor = value;
                          });
                          break;
                        case "themeColor":
                          setState(() {
                            this.themeColor = value;
                          });
                          break;
                        case "textColor":
                          setState(() {
                            this.textColor = value;
                          });
                          break;
                        case "secondaryBackground":
                          setState(() {
                            this.secondaryBackground = value;
                          });
                          break;
                        case "themeColorOnButton":
                          setState(() {
                            this.textOnTheme = value;
                          });
                          break;
                      }
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void findDownloadURL() {
    FirebaseDatabase.instance
        .ref()
        .child("Apps")
        .child(owner!.appId)
        .child("appIcon")
        .once()
        .then((value) {
      var imageUrl = value.snapshot.value as String;
      setState(() {
        print('changes');
        downloadURL = imageUrl;
      });
    });
  }

  Future selectFile() async {
    print("hi there");
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;

      // upload file
      await FirebaseStorage.instance
          .ref('App/${owner!.appId}/appIcon')
          .putData(fileBytes!);
      String downloadURL = await FirebaseStorage.instance
          .ref('App/${owner!.appId}/appIcon')
          .getDownloadURL();
      FirebaseDatabase.instance
          .ref()
          .child("Apps")
          .child(owner!.appId)
          .child("appIcon")
          .set(downloadURL);
      setState(() {
        this.downloadURL = downloadURL;
      });
    }
  }

  Future pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
      uploadImageToFirebase(imageTemp);
    } on PlatformException catch (e) {
      print("failed to pick image: $e");
    }
  }

  Future uploadImageToFirebase(File imageTemp) async {
    EasyLoading.show(status: "Uploading Logo");
    try {
      final ref =
          storage.ref().child("App").child(owner!.appId).child("appIcon");
      await ref.putFile(imageTemp);
      String downloadURL = await FirebaseStorage.instance
          .ref('App/${owner!.appId}/appIcon')
          .getDownloadURL();
      FirebaseDatabase.instance
          .ref()
          .child("Apps")
          .child(owner!.appId)
          .child("appIcon")
          .set(downloadURL);
      setState(() {
        this.downloadURL = downloadURL;
      });
      findDownloadURL();
      EasyLoading.showSuccess("Success!");
    } catch (e) {
      EasyLoading.showError("Error: ${e.toString()}}");
      print('error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var isSmall = MediaQuery.of(context).size.width < 1210;
    return EyeDrop(
      child: Scaffold(
        backgroundColor: isLight ? Colors.white : navy500,
        body: isSmall
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackButton(),
                    navigationBar(
                      context,
                      "Customize Theme",
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 22,
                        left: 25,
                        right: 25,
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: isLight ? slate500 : Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: (MediaQuery.of(context).size.width - 75) / 2,
                            height:
                                (MediaQuery.of(context).size.width - 75) / 2,
                            child: Container(
                              child: (downloadURL != null)
                                  ? ClipRRect(
                                      child: Image.network(
                                        downloadURL!,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    )
                                  : ClipRRect(
                                      child: Image.asset(
                                        isLight
                                            ? 'assets/images/unknown_logo_light.png'
                                            : 'assets/images/unknown_logo_dark.png',
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                print('hi there');
                                if (kIsWeb) {
                                  print("is web");
                                  selectFile();
                                } else {
                                  print("is not web");
                                  pickImage();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: mainBlue,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                width:
                                    (MediaQuery.of(context).size.width - 75) /
                                        2,
                                height:
                                    (MediaQuery.of(context).size.width - 75) /
                                        2,
                                child: Stack(
                                  children: [
                                    Container(
                                      child: Center(
                                        child: CustomText(
                                          color: mainBlue,
                                          text: "Upload Logo",
                                          fontWeight: FontWeight.bold,
                                          align: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
                      child: colorRow(context, "Theme Color (Main Color)",
                          "themeColor", themeColor ?? Colors.transparent),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
                      child: colorRow(
                        context,
                        "Background Color (Normally White)",
                        "backgroundColor",
                        backgroundColor ?? Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
                      child: colorRow(
                        context,
                        "Text Color (Presented on Background)",
                        "textColor",
                        textColor ?? Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
                      child: colorRow(
                        context,
                        "Text Color (Presented on Theme Color)",
                        "themeColorOnButton",
                        textOnTheme ?? Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
                      ),
                      child: colorRow(
                        context,
                        "Secondary Background (Smaller Views)",
                        "secondaryBackground",
                        secondaryBackground ?? Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackButton(),
                    navigationBar(
                      context,
                      "Customize Theme",
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 22,
                        left: 25,
                        right: 25,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: isLight ? slate500 : Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: 150,
                            height: 150,
                            child: Container(
                              child: (downloadURL != null)
                                  ? ClipRRect(
                                      child: Image.network(
                                        downloadURL!,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    )
                                  : ClipRRect(
                                      child: Image.asset(
                                        isLight
                                            ? 'assets/images/unknown_logo_light.png'
                                            : 'assets/images/unknown_logo_dark.png',
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                print('hi there');
                                if (kIsWeb) {
                                  print("is web");
                                  selectFile();
                                } else {
                                  print("is not web");
                                  pickImage();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: mainBlue,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                width: 150,
                                height: 150,
                                child: Stack(
                                  children: [
                                    Container(
                                      child: Center(
                                        child: CustomText(
                                          color: mainBlue,
                                          text: "Upload Logo",
                                          fontWeight: FontWeight.bold,
                                          align: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
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
  }
}
