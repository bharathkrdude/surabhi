import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/controller/auth/auth_controller.dart';
import 'package:surabhi/controller/checklist/checklist_controller.dart';
import 'package:surabhi/controller/qr_controller/qr_controller.dart';
import 'package:surabhi/controller/toilet/toilet_cotroller.dart';
import 'package:surabhi/view/screens/botttomnavigation/bottom_navigation_widget.dart';
import 'package:surabhi/view/screens/dashboard/screen_dashboard.dart';
import 'package:surabhi/view/screens/login/login_screen.dart';
import 'package:surabhi/view/screens/profile/profile_screen.dart';
import 'package:surabhi/view/screens/splash/screen_splash.dart';
import 'package:surabhi/view/widgets/qr_code_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ToiletController());
  Get.put(ChecklistController());
  Get.put(AuthController());
  Get.put(QRScannerController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Surabhi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        primaryColor: secondary,
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/home', page: () => const BottomNavigationWidget()),
        GetPage(name: '/dash', page: () => const ScreenDashboard()),
        GetPage(name: '/profile', page: () => const ProfilePage()),
        GetPage(name: '/qr', page: () => const QRCodeScannerPage())
      ],
    );
  }
}
