import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surabhi/model/cheklist/checklist_model.dart';
import 'dart:convert';

import 'package:surabhi/model/cheklist/complaint_model.dart';



class ChecklistController extends GetxController {
  var isLoading = true.obs;
  var checklists = <ChecklistModel>[].obs;
  var complaints = <ComplaintModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchChecklist(1); // Replace with dynamic toiletId
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> fetchChecklist(int toiletId) async {
    try {
      isLoading(true);
      final token = await getAuthToken();
      final response = await http.get(
        Uri.parse('https://esmagroup.online/surabhi/api/v1/get-check-list?toilet_id=$toiletId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status']) {
          checklists.value = (data['checklists'] as List)
              .map((item) => ChecklistModel.fromJson(item))
              .toList();
          complaints.value = (data['complaints'] as List)
              .map((item) => ComplaintModel.fromJson(item))
              .toList();
        } else {
          Get.snackbar('Error', data['message'] ?? 'Failed to load checklist');
        }
      } else {
        Get.snackbar('Error', 'Failed to load checklist. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching checklist: $e');
      Get.snackbar('Error', 'Error fetching checklist: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> submitChecklist(int toiletId) async {
    bool allAnswered = checklists.every((item) => item.isAnswered);

    if (!allAnswered) {
      Get.snackbar('Error', 'Please answer all questions.');
      return;
    }

    var submissionData = {
      'toilet_id': toiletId,
      'answers': checklists.map((item) => {
        'check_list_id': item.id,
        'answer': item.isAnswered ? 'Yes' : 'No',
      }).toList(),
    };

    try {
      var response = await http.post(
        Uri.parse('https://esmagroup.online/surabhi/api/v1/store-check-list'),
        headers: {
          'Authorization': 'Bearer ${await getAuthToken()}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(submissionData),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Checklist submitted successfully');
      } else {
        Get.snackbar('Error', 'Failed to submit checklist');
      }
    } catch (e) {
      print('Error submitting checklist: $e');
      Get.snackbar('Error', 'Error submitting checklist: $e');
    }
  }
}
