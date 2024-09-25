import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surabhi/controller/auth/authController.dart';
import 'package:surabhi/view/screens/login/login_screen.dart';
import 'package:surabhi/view/screens/main/screen_main.dart';
import 'package:surabhi/view/screens/splash/screen_splash.dart';

void main() {
  Get.put(AuthController()); // Ensure AuthController is initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/home', page: () => const ScreenMain()),
      ],
    );
  }
}
