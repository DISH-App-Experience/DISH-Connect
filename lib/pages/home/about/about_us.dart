import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/widgets/about/textfield_row.dart';
import 'package:dish_connect/widgets/custom_back_button.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:dish_connect/widgets/navigation_bar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var isSmall = MediaQuery.of(context).size.width < 1210;
    TextEditingController storyTF = TextEditingController();
    TextEditingController websiteTF = TextEditingController();
    TextEditingController phoneNumberTF = TextEditingController();
    TextEditingController twitterTF = TextEditingController();
    TextEditingController instagramTF = TextEditingController();
    TextEditingController facebookTF = TextEditingController();
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
                      TextInputType.url,
                      phoneNumberTF,
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
                    ),
                  ),
                  SizedBox(
                    height: 200,
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
                ],
              ),
            ),
    );
  }
}
