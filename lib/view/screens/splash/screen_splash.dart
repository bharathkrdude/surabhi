import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/view/screens/login/login_screen.dart';
import 'package:surabhi/view/screens/main/screen_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Fade in animation
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Start the animation
    _controller.forward();

    // Check login status
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Navigate after a delay of 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (isLoggedIn) {
        // If user is logged in, navigate to Main Page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ScreenMain(),
          ),
        );
      } else {
        // If not logged in, navigate to Login Page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeInAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                logo,
                height: 100, // Adjust this value to make the logo image smaller
              ),
              const SizedBox(height: 20), // Space between images
              Image.asset(
                logoText,
                height: 30, // Adjust this value to make the text image smaller
              ),
            ],
          ),
        ),
      ),
    );
  }
}
