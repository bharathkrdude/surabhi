import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surabhi/model/user/userModel.dart';
import 'package:surabhi/services/api_service.dart';

class AuthController extends GetxController {
  Rx<UserModel> user = UserModel().obs;  // Store user info
  RxBool isLoggedIn = false.obs;         // Boolean to track login state
  RxBool isLoading = false.obs;          // Boolean to show loading state
  RxBool obscurePassword = true.obs;     // Toggle password visibility
  RxString errorMessage = ''.obs;        // Store error messages

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  // Check if token exists in SharedPreferences
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
    } else {
      isLoggedIn.value = false;
      Get.offAllNamed('/login');
    }
  }

Future<void> login(String email, String password) async {
  isLoading.value = true;
  var response = await ApiService.login(email, password); // API call
  if (response != null && response.token != null) {
    // Save token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', response.token!);
    prefs.setBool('isLoggedIn', true); // Set login status

    // Update user model
    user.value = response;
    isLoggedIn.value = true;
    Get.offAllNamed('/home');  // Navigate to home screen
  } else {
    errorMessage.value = "Invalid credentials";
  }
  isLoading.value = false;
}
 static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  // Logout function
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    isLoggedIn.value = false;
    Get.offAllNamed('/login'); // Navigate to login screen
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }
}
