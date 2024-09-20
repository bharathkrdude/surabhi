import 'package:flutter/material.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/view/screens/login/widgets/clipped_container.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true, // Ensure layout resizes when keyboard appears
      body: SmoothContainerWithImage(
        height: 0.5,
        color: primaryButton,
        imageUrl: 'https://shorturl.at/dtmRa',
      ),
    );
  }
}



