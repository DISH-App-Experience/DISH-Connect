import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/widgets/about/textfield_row.dart';
import 'package:dish_connect/widgets/about/textfield_row_web.dart';
import 'package:dish_connect/widgets/custom_back_button.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:dish_connect/widgets/navigation_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  TextEditingController storyTF = TextEditingController();
  TextEditingController websiteTF = TextEditingController();
  TextEditingController phoneNumberTF = TextEditingController();
  TextEditingController twitterTF = TextEditingController();
  TextEditingController instagramTF = TextEditingController();
  TextEditingController facebookTF = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    aboutRef.child("aboutUs").once().then((value) {
      setState(() {
        storyTF.text = value.snapshot.value as String;
      });
    });

    aboutRef.child("websiteLink").once().then((value) {
      setState(() {
        websiteTF.text = value.snapshot.value as String;
      });
    });

    aboutRef.child("phoneNumber").once().then((value) {
      setState(() {
        phoneNumberTF.text = value.snapshot.value as String;
      });
    });

    aboutRef.child("twitterLink").once().then((value) {
      setState(() {
        twitterTF.text = value.snapshot.value as String;
      });
    });

    aboutRef.child("instagramLink").once().then((value) {
      setState(() {
        instagramTF.text = value.snapshot.value as String;
      });
    });

    aboutRef.child("facebookLink").once().then((value) {
      setState(() {
        facebookTF.text = value.snapshot.value as String;
      });
    });
  }

  void updateAboutValues(String id) {
    var ref = FirebaseDatabase.instance
        .ref()
        .child("Apps")
        .child(owner!.appId)
        .child("about")
        .child(id);
    switch (id) {
      case "aboutUs":
        ref.set(storyTF.text);
        break;
      case "websiteLink":
        ref.set(websiteTF.text);
        break;
      case "phoneNumber":
        ref.set(phoneNumberTF.text);
        break;
      case "instagramLink":
        ref.set(instagramTF.text);
        break;
      case "facebookLink":
        ref.set(facebookTF.text);
        break;
      case "twitterLink":
        ref.set(twitterTF.text);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var isSmall = MediaQuery.of(context).size.width < 1210;
    return Scaffold(
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
                    "About Us",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: textFieldRow(
                      "Your Story",
                      true,
                      TextInputType.name,
                      storyTF,
                      () {
                        updateAboutValues("aboutUs");
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: textFieldRow(
                      "Website Link",
                      false,
                      TextInputType.url,
                      websiteTF,
                      () {
                        updateAboutValues("websiteLink");
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: textFieldRow(
                      "Phone Number",
                      false,
                      TextInputType.phone,
                      phoneNumberTF,
                      () {
                        updateAboutValues("phoneNumber");
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: textFieldRow(
                      "Twitter Link",
                      false,
                      TextInputType.url,
                      twitterTF,
                      () {
                        updateAboutValues("twitterLink");
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: textFieldRow(
                      "Instagram Link",
                      false,
                      TextInputType.url,
                      instagramTF,
                      () {
                        updateAboutValues("instagramLink");
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: textFieldRow(
                      "Facebook Link",
                      false,
                      TextInputType.url,
                      facebookTF,
                      () {
                        updateAboutValues("facebookLink");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: CustomText(
                      text: "There's no save button, it's done realtime!",
                      size: 12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
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
                    "About Us",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: webTextFieldRow(
                      "Your Story",
                      true,
                      TextInputType.name,
                      storyTF,
                      () {
                        updateAboutValues("aboutUs");
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: webTextFieldRow(
                      "Website Link",
                      false,
                      TextInputType.url,
                      websiteTF,
                      () {
                        updateAboutValues("websiteLink");
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: webTextFieldRow(
                      "Phone Number",
                      false,
                      TextInputType.phone,
                      phoneNumberTF,
                      () {
                        updateAboutValues("phoneNumber");
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: webTextFieldRow(
                      "Twitter Link",
                      false,
                      TextInputType.url,
                      twitterTF,
                      () {
                        updateAboutValues("twitterLink");
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: webTextFieldRow(
                      "Instagram Link",
                      false,
                      TextInputType.url,
                      instagramTF,
                      () {
                        updateAboutValues("instagramLink");
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: webTextFieldRow(
                      "Facebook Link",
                      false,
                      TextInputType.url,
                      facebookTF,
                      () {
                        updateAboutValues("facebookLink");
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 725,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 25,
                      ),
                      child: Center(
                        child: CustomText(
                          text: "There's no save button, it's done realtime!",
                          size: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
    );
  }
}
