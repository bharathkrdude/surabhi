import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surabhi/model/user/userModel.dart';
import 'package:surabhi/services/api_service.dart';

class AuthController extends GetxController {
  Rx<UserModel> user = UserModel().obs;  // Store user info
  RxBool isLoggedIn = false.obs;         // Boolean to track login state

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

  // Login function
  Future<void> login(String email, String password) async {
    var response = await ApiService.login(email, password); // API call
    if (response != null && response.token != null) {
      // Save token
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response.token!);

      // Update user model
      user.value = response;
      isLoggedIn.value = true;
      Get.offAllNamed('/home');  // Navigate to home screen
    } else {
      Get.snackbar("Login Failed", "Invalid credentials");
    }
  }

  // Logout function
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    isLoggedIn.value = false;
    Get.offAllNamed('/login'); // Navigate to login screen
  }
}
