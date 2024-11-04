import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surabhi/view/screens/test/testDelete.dart';

import '../../model/toilet/cluster_model.dart';
// Assuming you have a Toilet model defined

class ToiletController extends GetxController {
  var toilets = <Toilet>[].obs;
  var clusters = <Cluster>[].obs;
  var isLoading = true.obs;
  var selectedStatus = 'All'.obs;
  var selectedCluster =
      Cluster(id: 0, clusterName: 'All Clusters', clusterCode: '').obs;

  @override
  void onInit() {
    fetchClusters(); 
    // Fetch clusters when the controller initializes
    print("Clusters in controller: ${clusters.map((c) => c.clusterName).toList()}");

    fetchToilets(initialFetch: true); // Fetch all toilets initially
    super.onInit();
  }void fetchClusters() async {
  try {
    isLoading(true); // Set loading to true

    // Get token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Using 'token' key


    if (token == null) {
      Get.snackbar('Error', 'Token not found'); // Show error if token is null
      return; // Exit the function if token is not found
    }

    // Log the API call
    print('Making API call to: https://esmagroup.online/surabhi/api/v1/get-clusters');

    // Make the HTTP GET request
    final response = await http.get(
      Uri.parse('https://esmagroup.online/surabhi/api/v1/get-clusters'),
      headers: {
        'Authorization': 'Bearer $token', // Include the token in headers
        'Content-Type': 'application/json',
      },
    );
print('Making API call to: https://esmagroup.online/surabhi/api/v1/get-clusters with token: $token');

    // Log response status and body for debugging
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // Check if the response is successful (HTTP 200)
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body); // Decode the JSON response

      // Check if the status is true in the response
      if (jsonData['status'] == true) {
        var clustersData = jsonData['clusters'] as List; // Extract clusters from the response
        clusters.value = clustersData.map((json) => Cluster.fromJson(json)).toList(); // Map JSON to Cluster objects
        
        // Log the clusters fetched
        print('Fetched clusters: ${clusters.map((c) => c.clusterName).toList()}');

        // Add default 'All Clusters' option at the beginning of the list
        clusters.insert(0, Cluster(id: 0, clusterName: 'All Clusters', clusterCode: ''));
      } else {
        Get.snackbar('Error', jsonData['message']); // Show error message if status is false
      }
    } else {
      Get.snackbar('Error', 'Failed to load clusters: ${response.statusCode}'); // Handle non-200 responses
    }
  } catch (e) {
    print('Error during fetchClusters: $e'); // Log any exception that occurs
    Get.snackbar('Error', e.toString()); // Show error message
  } finally {
    isLoading(false); // Set loading to false at the end
  }
}

  // Fetch toilets based on selected status and cluster
  Future<void> fetchToilets({bool initialFetch = false}) async {
    try {
      isLoading(true);
      String statusParam = selectedStatus.value == 'All'
          ? ''
          : selectedStatus.value.toLowerCase();
      String clusterParam = selectedCluster.value.id == 0
          ? ''
          : selectedCluster.value.id.toString();

      // If initial fetch, pass empty parameters to get all toilets
      if (initialFetch) {
        statusParam = '';
        clusterParam = '';
      }

      var url = Uri.parse(
          'https://esmagroup.online/surabhi/api/v1/get-toilets?status=$statusParam&clusters=$clusterParam');

      // Retrieve token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        Get.snackbar('Error', 'Token not found');
        return;
      }

      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });
  print('Response status: ${response.statusCode}');
print('Response body: ${response.body}');
      if (response.statusCode == 200) {
      

        var jsonData = json.decode(response.body);
        toilets.value = (jsonData['toilets'] as List)
            .map((item) => Toilet.fromJson(item))
            .toList();
      } else {
        Get.snackbar('Error', 'Failed to load toilets: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
    
  }

  // Update the selected status and trigger fetch of toilets
  void updateStatus(String newStatus) {
    selectedStatus.value = newStatus;
    // fetchToilets(); // Refetch toilets based on updated status
  }

  // Update selected cluster by ID and trigger fetch of toilets
  void updateClusterById(int clusterId) {
    selectedCluster.value = clusters.firstWhere(
        (cluster) => cluster.id == clusterId,
        orElse: () =>
            Cluster(id: 0, clusterName: 'All Clusters', clusterCode: ''));
    // fetchToilets(); // Refetch toilets based on selected cluster
  }
}
