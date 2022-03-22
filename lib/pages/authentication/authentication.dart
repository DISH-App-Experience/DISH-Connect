import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/layout.dart';
import 'package:dish_connect/routing/routes.dart';
import 'package:dish_connect/services/owner.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:dish_connect/widgets/main_button.dart';
import 'package:dish_connect/widgets/main_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/instance_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'dart:async';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        print("done");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: isLight ? backgroundLight : backgroundDark,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Image.asset(
                        'assets/images/rounded_icon.png',
                        height: 60,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    CustomText(
                      text: "Sign In",
                      size: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                MainTextField(
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  controller: emailController,
                ),
                SizedBox(
                  height: 15,
                ),
                MainTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                ),
                SizedBox(
                  height: 30,
                ),
                MainButton(
                  text: "Sign In",
                  function: () async {
                    HapticFeedback.heavyImpact();
                    signIn();
                  },
                ),
                SizedBox(
                  height: 150,
                ),
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  highlightColor: Colors.transparent,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Easy to use restaurant app? ",
                          style: TextStyle(
                            color: isLight ? Colors.black : Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: "Learn More! ",
                          style: TextStyle(
                            color: mainBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    const url = "https://dish-digital.netlify.app/";
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    EasyLoading.show(status: "Signing In");
    String email = emailController.text;
    String password = passwordController.text;
    if (email != "" && password != "") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        getOwnerInformation();
        Timer(Duration(seconds: 3), () {
          EasyLoading.dismiss();
          Get.toNamed(LoadingPageRoute);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          EasyLoading.showError("No user found for that email.");
        } else if (e.code == 'wrong-password') {
          EasyLoading.showError("Wrong password provided for that user.");
        } else {
          EasyLoading.showError("Error, try again");
        }
      }
    } else {
      EasyLoading.showError("Fields cannot be empty");
    }
  }
}
