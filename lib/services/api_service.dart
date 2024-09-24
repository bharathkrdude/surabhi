import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:surabhi/model/user/userModel.dart';

class ApiService {
  static const baseUrl = 'https://esmagroup.online/surabhi/api/v1/';

  // Login API call
  static Future<UserModel?> login(String email, String password) async {
    final url = Uri.parse('${baseUrl}login');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}
