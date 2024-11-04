// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:surabhi/model/toilet/cluster_model.dart';

// class ClusterController extends GetxController {
//   var clusters = <Cluster>[].obs;  // Observable list for clusters
//   var isLoading = true.obs;        // Loading state

//   @override
//   void onInit() {
//     fetchClusters();  // Fetch clusters when controller is initialized
//     super.onInit();
//   }

//   // Fetch clusters with token in headers
// void fetchClusters() async {
//   try {
//     isLoading(true);

//     // Get token from SharedPreferences
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');  // Using 'token' key

//     if (token == null) {
//       Get.snackbar('Error', 'Token not found');
//       return;
//     }

//     // Print token for debugging
//     print('Token from SharedPreferences: $token');

//     // Make API call with Authorization header
//     final response = await http.get(
//       Uri.parse('https://esmagroup.online/surabhi/api/v1/get-clusters'),
//       headers: {
//         'Authorization': 'Bearer $token',  // Ensure correct token format
//         'Content-Type': 'application/json',
//       },
//     );

//     // Print response for debugging
//     print('Response Status: ${response.statusCode}');
//     print('Response Body: ${response.body}');

//     if (response.statusCode == 200) {
//       var jsonData = jsonDecode(response.body);
//       if (jsonData['status'] == true) {
//         var clustersData = jsonData['clusters'] as List;
//         clusters.value = clustersData.map((json) => Cluster.fromJson(json)).toList();
//       } else {
//         Get.snackbar('Error', jsonData['message']);
//       }
//     } else {
//       Get.snackbar('Error', 'Failed to load clusters: ${response.statusCode}');
//     }
//   } catch (e) {
//     Get.snackbar('Error', e.toString());
//   } finally {
//     isLoading(false);
//   }
// }

// }
