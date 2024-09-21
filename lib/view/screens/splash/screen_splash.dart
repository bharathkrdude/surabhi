

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surabhi/view/screens/login/login_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>   const LoginScreen(),
        ),
      );
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/surbhi_logo-removebg-preview.png',
        ),
      ),
    );
  }
}
