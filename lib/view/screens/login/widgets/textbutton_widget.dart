import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.24,
      height: MediaQuery.of(context).size.height * 0.045,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color.fromARGB(255, 214, 8, 8),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton.icon(
        onPressed: () {
          // Your onPressed functionality
        },
        icon: const Icon(
          Icons.short_text_sharp, // Filter icon
          color: Colors.black,
        ),
        label: const Text(
          'Filter',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
