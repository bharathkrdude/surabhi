import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surabhi/model/toilet/cluster_model.dart';
import 'package:surabhi/model/toilet/toilet_model.dart';

class ToiletController extends GetxController {
  // Observable properties
  var clusters = <Cluster>[].obs;               // List of clusters
  var toilets = <ToiletModel>[].obs;            // List of toilets (to use directly in UI)
  var isLoading = true.obs;                     // To track loading state
  var selectedCluster = Rx<String?>(null);      // Selected cluster filter
  var selectedStatus = Rx<String?>(null);       // Selected status filter

  final _filteredToiletsStreamController = StreamController<List<ToiletModel>>.broadcast();

  // Expose the filtered toilets stream
  Stream<List<ToiletModel>> get filteredToiletsStream => _filteredToiletsStreamController.stream;

  @override
  void onInit() {
    super.onInit();
    fetchClusters();           // Fetch clusters on initialization
    fetchFilteredToilets();    // Fetch toilets data initially (without filters)
  }

  // Fetch auth token from SharedPreferences
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Fetch clusters data from the API
  Future<void> fetchClusters() async {
    try {
      final token = await getAuthToken();
      var response = await http.get(
        Uri.parse('https://esmagroup.online/surabhi/api/v1/get-clusters'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['status'] == true && jsonData['clusters'] is List) {
          clusters.assignAll((jsonData['clusters'] as List)
              .map((item) => Cluster.fromJson(item))
              .toList());
        } else {
          print('Invalid response structure for clusters');
        }
      } else {
        print('Failed to fetch clusters: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while fetching clusters: $e');
    }
  }

  // Fetch filtered toilets from the API based on the selected filters
  Future<void> fetchFilteredToilets() async {
    isLoading(true);
    try {
      final token = await getAuthToken();

      // Build the query parameters
      String status = selectedStatus.value ?? '';
      String cluster = selectedCluster.value ?? '';

      String url = 'https://esmagroup.online/surabhi/api/v1/get-toilets?status=$status&clusters=$cluster';
      
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['status'] == true && jsonData['toilets'] is List) {
          List<ToiletModel> fetchedToilets = (jsonData['toilets'] as List)
              .map((item) => ToiletModel.fromJson(item))
              .toList();

          toilets.assignAll(fetchedToilets); // Update the toilets list
          _filteredToiletsStreamController.add(fetchedToilets); // Emit to stream
        } else {
          print('Invalid response structure for toilets');
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

  // Method to clear filters
  void clearFilters() {
    selectedCluster.value = '';  // Reset cluster to default (e.g., all clusters)
    selectedStatus.value = '';   // Reset status to default (no specific status)
    fetchFilteredToilets();      // Re-fetch toilets with no filters
  }

  // Set selected cluster and fetch filtered toilets
  void setSelectedCluster(String? clusterCode) {
    selectedCluster.value = clusterCode;
    fetchFilteredToilets();
  }

  // Set selected status and fetch filtered toilets
  void setSelectedStatus(String? status) {
    selectedStatus.value = status;
    fetchFilteredToilets();
  }

  @override
  void onClose() {
    _filteredToiletsStreamController.close();
    super.onClose();
  }
}
