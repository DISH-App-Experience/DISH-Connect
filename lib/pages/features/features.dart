import 'package:dish_connect/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class FeatureManagerPage extends StatefulWidget {
  const FeatureManagerPage({Key? key}) : super(key: key);

  @override
  State<FeatureManagerPage> createState() => _FeatureManagerPageState();
}

class _FeatureManagerPageState extends State<FeatureManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        text: "Features Page",
      ),
    );
  }
}
