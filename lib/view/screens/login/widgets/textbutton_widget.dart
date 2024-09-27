import 'package:flutter/material.dart';
import 'package:surabhi/constants/colors.dart';

class TextButtonWidget extends StatelessWidget {
  final VoidCallback onPressed; // Accept onPressed as a parameter

  const TextButtonWidget({
    Key? key,
    required this.onPressed, required String text, // Make onPressed required
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.24,
      height: MediaQuery.of(context).size.height * 0.045,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: primaryButton,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton.icon(
        style: const ButtonStyle(),
        onPressed: onPressed, // Use the passed onPressed function
        icon: const Icon(
          Icons.short_text_sharp, // Filter icon
          color: primaryButton,
        ),
        label: const Text(
          'Filter',
          style: TextStyle(
            color: primaryButton,
          ),
        ),
      ),
    );
  }
}
