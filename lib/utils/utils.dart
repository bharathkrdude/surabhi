import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}


class Utils {
  
void showToast(String message, {bool isSuccess = false}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  });
}

}
