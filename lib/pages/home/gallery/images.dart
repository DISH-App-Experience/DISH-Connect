import 'dart:async';
import 'package:dish_connect/helpers/global_variables.dart';
import 'package:dish_connect/models/image.dart';
import 'package:dish_connect/services/image_services.dart';
import 'package:dish_connect/widgets/navigation_bar.dart';
import 'package:dish_connect/widgets/top_nav.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dish_connect/constants/colors.dart';
import 'package:dish_connect/widgets/custom_back_button.dart';
import 'package:dish_connect/widgets/custom_text.dart';
import 'package:get/get.dart';

class ImageGallery extends StatefulWidget {
  const ImageGallery({Key? key}) : super(key: key);

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  List<ImageGalleryObject>? images;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var isSmall = MediaQuery.of(context).size.width < 1210;
    return Scaffold(
      backgroundColor: isLight ? Colors.white : navy500,
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainBlue,
        onPressed: () {
          print("hi");
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
            // Padding(
            //   padding: const EdgeInsets.only(
            //     top: 42,
            //     left: 25,
            //     right: 25,
            //   ),
            //   child: StreamBuilder(
            //     stream: photosRef.onValue,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData && !snapshot.hasError) {
            //         final images = snapshot.data!.sn.value;
            //         return GridView.builder(
            //           shrinkWrap: true,
            //           physics: NeverScrollableScrollPhysics(),
            //           itemCount: images.length,
            //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: isSmall ? 2 : 6,
            //             mainAxisSpacing: isSmall ? 12.5 : 37,
            //             crossAxisSpacing: isSmall ? 12.5 : 37,
            //           ),
            //           itemBuilder: (context, index) {
            //             ImageGalleryObject image = images[index];
            //             return Container(
            //               decoration: BoxDecoration(
            //                 color: isLight ? blue100 : Colors.black,
            //                 borderRadius: BorderRadius.circular(
            //                   20,
            //                 ),
            //               ),
            //               height: 200,
            //               width: 200,
            //               child: ClipRRect(
            //                 child: Image.network(
            //                   image.url,
            //                   fit: BoxFit.fill,
            //                 ),
            //                 borderRadius: BorderRadius.circular(20),
            //               ),
            //             );
            //           },
            //         );
            //       } else {
            //         return Center(
            //           child: CupertinoActivityIndicator(),
            //         );
            //       }
            //     },
            //   ),
            // ),
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
