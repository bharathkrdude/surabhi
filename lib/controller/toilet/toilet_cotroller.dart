import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:surabhi/model/toilet/toilet_model.dart';

class ToiletController extends GetxController {
  var toilets = <ToiletModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchToilets();
    super.onInit();
  }
Future<String?> getAuthToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}
void fetchToilets() async {
  isLoading(true);
  try {
    final token = await getAuthToken();
    var response = await http.get(
      Uri.parse('https://esmagroup.online/surabhi/api/v1/get-toilets'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['status'] == true && jsonData['toilets'] is List) {
        toilets.value = (jsonData['toilets'] as List)
            .map((item) => ToiletModel.fromJson(item))
            .toList();
        print('Toilets fetched: ${toilets.length}');
      } else {
        print('Invalid response structure');
      }
    } else {
      print('Failed to fetch toilets: ${response.statusCode}');
    }
  } catch (e) {
    print('Error while fetching toilets: $e');
  } finally {
    isLoading(false);
  }
}

}


