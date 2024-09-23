import 'package:flutter/material.dart';
import 'package:surabhi/model/user/userModel.dart';
import 'package:surabhi/view/screens/login/login_screen.dart';

class UserController {
  final UserModel _userModel = UserModel();

  // Logout logic
  Future<void> logout(BuildContext context) async {
    // Clear the token using the model
    await _userModel.clearToken();

    // Navigate to the login screen and remove previous routes
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) =>  LoginScreen()),
      (Route<dynamic> route) => false,  // Removes all previous routes
    );
  }
}
