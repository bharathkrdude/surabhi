import 'package:flutter/material.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/view/screens/login/widgets/clipped_container.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: backgroundColorlightgrey,
      resizeToAvoidBottomInset: true, // Ensure layout resizes when keyboard appears
      body: CurvedLoginScreen(
        height: 0.5,
        color: Colors.white,
        imageUrl: 'https://shorturl.at/dtmRa',
      ),
    );
  }
}



