import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surabhi/view/screens/test/testDelete.dart';

class ToiletController extends GetxController {
  var toilets = <Toilet>[].obs;
  var clusters = <Cluster>[].obs;
  var isLoading = true.obs;
  var selectedStatus = 'All'.obs;  // Initialize with 'All'
  var selectedCluster = Cluster(id: 0, clusterName: 'All Clusters', clusterCode: '').obs;

 @override
void onInit() {
  fetchClusters();  // Fetch clusters when the controller initializes
  fetchToilets(initialFetch: true);   // Fetch all toilets initially
  super.onInit();
}


  Future<void> fetchClusters() async {
    try {
      var url = Uri.parse('https://esmagroup.online/surabhi/api/v1/get-clusters');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      print('Retrieved token: $token');

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        clusters.value = [
          Cluster(id: 0, clusterName: 'All Clusters', clusterCode: ''),  // Add default option
          ...(jsonData['clusters'] as List).map((item) => Cluster.fromJson(item))
        ];
      } else {
        print('Error fetching clusters: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception while fetching clusters: $e');
    }
  }

 void fetchToilets({bool initialFetch = false}) async {
  try {
    isLoading(true);  // Start loading
    String statusParam = selectedStatus.value == 'All' ? '' : selectedStatus.value.toLowerCase();
    String clusterParam = selectedCluster.value.id == 0 ? '' : selectedCluster.value.id.toString();
    
    // If it's the initial fetch, pass empty parameters to get all toilets
    if (initialFetch) {
      statusParam = '';
      clusterParam = '';
    }

    var url = Uri.parse('https://esmagroup.online/surabhi/api/v1/get-toilets?status=$statusParam&clusters=$clusterParam');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('Retrieved token: $token');

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      toilets.value = (jsonData['toilets'] as List).map((item) => Toilet.fromJson(item)).toList();
    } else {
      print('Error fetching toilets: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Exception while fetching toilets: $e');
  } finally {
    isLoading(false);  // Stop loading
  }
}

  void updateStatus(String status) {
    selectedStatus.value = status;  // Update the selected status
    fetchToilets();  // Refetch toilets based on the new status
  }

  void updateCluster(Cluster cluster) {
    selectedCluster.value = cluster;  // Update the selected cluster
    fetchToilets();  // Refetch toilets based on the new cluster
  }
}
