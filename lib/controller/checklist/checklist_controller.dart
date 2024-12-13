import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surabhi/model/cheklist/checklist_model.dart';
import 'package:surabhi/utils/utils.dart';
import 'dart:io';
import 'package:surabhi/view/widgets/success_page.dart';

class ChecklistController extends GetxController {
  final toiletCode = ''.obs;

  final checklists = <Checklist>[].obs;
  final complaints = <Complaint>[].obs;
  final isLoading = false.obs;
  final checklistAnswers = <String, String>{}.obs;
  final dioClient = dio.Dio();
  final images = List.generate(3, (index) => Rxn<File>());

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
        // Add this line to get toilet code
        toiletCode.value = response.data['toilet_code'] ?? '';

        checklists.value = (response.data['checklists'] as List)
            .map((item) => Checklist.fromJson(item))
            .toList();
        complaints.value = (response.data['complaints'] as List)
            .map((item) => Complaint.fromJson(item))
            .toList();
      } else {
        // Use toast for error message
        Utils().showToast(response.data['message'] ?? "Error occurred", isSuccess: false);
      }
    } catch (e) {
      // Use toast for error message
      Utils().showToast(e.toString(), isSuccess: false);
    } finally {
      isLoading.value = false;
    }
  }

  void updateChecklistAnswer({required int index, required String value}) {
    checklistAnswers["checklist[$index]"] = value;
    update();
  }

  // Method to set image at specific index
  void setImage(int index, File image) {
    if (index >= 0 && index < images.length) {
      images[index].value = image;
    }
  }

  // Method to remove image at specific index
  void removeImage(int index) {
    if (index >= 0 && index < images.length) {
      images[index].value = null;
    }
  }

  // Update submitChecklist method to handle multiple images
  Future<void> submitChecklist({required int toiletId, required String status}) async {
    isLoading.value = true;
    try {
      String? token = await _getToken();
      if (token == null) throw Exception("Token not found");

      dioClient.options.headers['Authorization'] = 'Bearer $token';

      final formData = dio.FormData();

      // Add toilet_id and status
      formData.fields.add(MapEntry('toilet_id', toiletId.toString()));
      formData.fields.add(MapEntry('status', status));

      // Add checklist answers
      checklistAnswers.forEach((key, value) {
        formData.fields.add(MapEntry(key, value));
      });

      // Add images
      for (int i = 0; i < images.length; i++) {
        if (images[i].value != null) {
          formData.files.add(MapEntry(
            'images[]',
            await dio.MultipartFile.fromFile(
              images[i].value!.path,
              filename: 'image_$i.jpg',
            ),
          ));
        }
      }

      final response = await dioClient.post(
        'https://esmagroup.online/surabhi/api/v1/store-check-list',
        data: formData,
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        // Clear images after successful submission
        for (var imageRx in images) {
          imageRx.value = null;
        }
        checklistAnswers.clear();
        Get.to(const SuccessPage());

        // Use toast for success message
        Utils().showToast("Checklist updated successfully", isSuccess: true);
        
        await fetchChecklistData(toiletId);
      } else {
        // Use toast for error message
        Utils().showToast(response.data['message'] ?? "Update failed", isSuccess: false);
      }
    } catch (e) {
      // Use toast for error message
      Utils().showToast(e.toString(), isSuccess: false);
    } finally {
      isLoading.value = false;
    }
  }
}
