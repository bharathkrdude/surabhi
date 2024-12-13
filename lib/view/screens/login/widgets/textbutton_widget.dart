import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surabhi/constants/colors.dart';

class TextButtonWidget extends StatelessWidget {
  final VoidCallback onPressed; // Accept onPressed as a parameter

   const TextButtonWidget({
    super.key,
    required this.onPressed, required String text, // Make onPressed required
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.24,
      height: MediaQuery.of(context).size.height * 0.045,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color:Get.theme.primaryColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton.icon(
        style: const ButtonStyle(),
        onPressed: onPressed, // Use the passed onPressed function
        icon:  Icon(
          Icons.short_text_sharp, // Filter icon
          color:secondary,
        ),
        label:  Text(
          'Filter',
          style:  TextStyle(
            color:  secondary,
          ),
        ),
      ),
    );
  }
}


