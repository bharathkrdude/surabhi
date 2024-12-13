import 'package:flutter/material.dart';
import 'package:surabhi/constants/colors.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Icon? icon;

  const PrimaryButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: primaryButton
      ),
      child: Material(
        color: secondary,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0), // Equal padding from both sides
            child: Row(
              children: [
                if (icon != null) icon!,
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}