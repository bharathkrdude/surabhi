import 'package:flutter/material.dart';
import 'package:surabhi/constants/colors.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      title: Text(
        title,
        style: const TextStyle(color: white,fontWeight: FontWeight.w500, ),
      ),
      centerTitle: true,
      backgroundColor: primaryButton,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}