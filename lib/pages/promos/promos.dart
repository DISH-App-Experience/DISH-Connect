import 'package:dish_connect/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class PromotionsPage extends StatefulWidget {
  const PromotionsPage({Key? key}) : super(key: key);

  @override
  State<PromotionsPage> createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        text: "Promotions Page",
      ),
    );
  }
}
