import 'package:flutter/material.dart';
import 'package:surabhi/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    required this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed, required InputDecoration decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: primaryButton),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: onSuffixIconPressed,
              )
            : null,
      ),
    );
  }
}