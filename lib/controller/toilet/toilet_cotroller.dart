import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:surabhi/model/toilet/toilet_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ToiletController extends GetxController {
  var toilets = <Toilet>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchToilets();
    super.onInit();
  }

  Future<void> fetchToilets() async {
    try {
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token'); // Replace 'token' with the key you used to save the token

      // Set up the request headers with the bearer token
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        Uri.parse('https://esmagroup.online/surabhi/toilets'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true) {
          List<Toilet> loadedToilets = [];
          for (var toilet in data['toilets']) {
            loadedToilets.add(Toilet.fromJson(toilet));
          }
          toilets.value = loadedToilets;
        }
      }
    } catch (e) {
      print('Error fetching toilets: $e');
    } finally {
      isLoading(false);
    }
  }
}
