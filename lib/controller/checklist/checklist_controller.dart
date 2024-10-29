
// checklist_controller.dart 
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surabhi/model/cheklist/checklist_model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ChecklistController extends GetxController {
  final checklists = <Checklist>[].obs;
  final complaints = <Complaint>[].obs;
  final isLoading = false.obs;
  final checklistAnswers = <String, String>{}.obs;
  final images = <File>[].obs;
  final dioClient = dio.Dio();
final image = Rxn<File>();  
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


    Future<void> fetchChecklistData(int toiletId) async {
    isLoading.value = true;
    try {
      String? token = await _getToken();
      if (token == null) throw Exception("Token not found");

      dioClient.options.headers['Authorization'] = 'Bearer $token';

      final response = await dioClient.get(
        'https://esmagroup.online/surabhi/api/v1/get-check-list',
        queryParameters: {'toilet_id': toiletId},
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        checklists.value = (response.data['checklists'] as List)
            .map((item) => Checklist.fromJson(item))
            .toList();
        complaints.value = (response.data['complaints'] as List)
            .map((item) => Complaint.fromJson(item))
            .toList();
      } else {
        Get.snackbar("Error", response.data['message']);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  // ... fetchChecklistData method remains same ...

  void updateChecklistAnswer({required int index, required String value}) {
    checklistAnswers["checklist[$index]"] = value; // Updated format to match API
    update();
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );
      
      if (image != null) {
        images.add(File(image.path));
        update();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to pick image: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> submitChecklist({required int toiletId, required String status}) async {
    isLoading.value = true;
    try {
      String? token = await _getToken();
      if (token == null) throw Exception("Token not found");

      dioClient.options.headers['Authorization'] = 'Bearer $token';

      // Create form data
      final formData = dio.FormData();
      
      // Add toilet_id
      formData.fields.add(MapEntry('toilet_id', toiletId.toString()));
      
      // Add status
      formData.fields.add(MapEntry('status', status));
      
      // Add checklist answers
      checklistAnswers.forEach((key, value) {
        formData.fields.add(MapEntry(key, value));
      });

      // Add images if any
      for (int i = 0; i < images.length; i++) {
        formData.files.add(MapEntry(
          'images[]',
          await dio.MultipartFile.fromFile(
            images[i].path,
            filename: 'image_$i.jpg',
          ),
        ));
      }

      final response = await dioClient.post(
        'https://esmagroup.online/surabhi/api/v1/store-check-list',
        data: formData,
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        // Clear images after successful submission
        images.clear();
        checklistAnswers.clear();
        
        Get.snackbar(
          "Success", 
          response.data['message'] ?? "Checklist updated successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await fetchChecklistData(toiletId);
      } else {
        Get.snackbar(
          "Error", 
          response.data['message'] ?? "Update failed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error", 
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < images.length) {
      images.removeAt(index);
      update();
    }
  }
}






