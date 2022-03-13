import 'package:dish_connect/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ReservationsPage extends StatefulWidget {
  const ReservationsPage({Key? key}) : super(key: key);

  @override
  State<ReservationsPage> createState() => _ReservationsPageState();
}

class _ReservationsPageState extends State<ReservationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText(
          text: "Reservations Page",
        ),
      ),
      backgroundColor: Colors.green,
    );
  }
}
