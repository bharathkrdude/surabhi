import 'package:flutter/material.dart';
import 'package:surabhi/view/screens/maintainanceDetail/widget/bookng_card_widget.dart';

class ScreenMaintananceDetails extends StatelessWidget {
  final int index;
  const ScreenMaintananceDetails({super.key,required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BookingCard(index:index ,),
          ],
        ),
      ),
    );
  }
}