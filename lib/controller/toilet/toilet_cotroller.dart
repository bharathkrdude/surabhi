import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:surabhi/view/screens/toilets/screen_toilet.dart';
import '../../model/toilet/cluster_model.dart';

class ToiletController extends GetxController {
  var toilets = <Toilet>[].obs;
  var clusters = <Cluster>[].obs;
  var isLoading = true.obs;
  var selectedStatus = 'All'.obs;
  var selectedCluster = Cluster(id: 0, clusterName: 'All Clusters', clusterCode: '').obs;

  // Observable list to store the valid toilet IDs
  final validToiletIds = <int>[].obs;

  @override
  void onInit() {
    fetchClusters();
    fetchToilets(initialFetch: true);
    super.onInit();
  }

  // Fetch clusters from API
  void fetchClusters() async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        Fluttertoast.showToast(msg: 'Token not found', toastLength: Toast.LENGTH_LONG);
        return;
      }

      final response = await http.get(
        Uri.parse('https://esmagroup.online/surabhi/api/v1/get-clusters'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['status'] == true) {
          var clustersData = jsonData['clusters'] as List;
          clusters.value = clustersData.map((json) => Cluster.fromJson(json)).toList();
          clusters.insert(0, Cluster(id: 0, clusterName: 'All Clusters', clusterCode: ''));
        } else {
          Fluttertoast.showToast(msg: jsonData['message'], toastLength: Toast.LENGTH_LONG);
        }
      } else {
        Fluttertoast.showToast(msg: 'Failed to load clusters', toastLength: Toast.LENGTH_LONG);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e', toastLength: Toast.LENGTH_LONG);
    } finally {
      isLoading(false);
    }
  }

  // Fetch toilets based on selected filters and update validToiletIds
  Future<void> fetchToilets({bool initialFetch = false}) async {
    try {
      isLoading(true);
      String statusParam = selectedStatus.value == 'All' ? '' : selectedStatus.value.toLowerCase();
      String clusterParam = selectedCluster.value.id == 0 ? '' : selectedCluster.value.id.toString();

      if (initialFetch) {
        statusParam = '';
        clusterParam = '';
      }

      var url = Uri.parse('https://esmagroup.online/surabhi/api/v1/get-toilets?status=$statusParam&clusters=$clusterParam');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        Fluttertoast.showToast(msg: 'Token not found', toastLength: Toast.LENGTH_LONG);
        return;
      }

      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        toilets.value = (jsonData['toilets'] as List).map((item) => Toilet.fromJson(item)).toList();
        validToiletIds.value = toilets.map((toilet) => toilet.id).toList(); // Update valid IDs
      } else {
        Fluttertoast.showToast(msg: 'Failed to load toilets', toastLength: Toast.LENGTH_LONG);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e', toastLength: Toast.LENGTH_LONG);
    } finally {
      isLoading(false);
    }
  }

  // Update selected status and trigger refetch of toilets
  void updateStatus(String newStatus) {
    selectedStatus.value = newStatus;
    fetchToilets();
  }

  // Update selected cluster by ID and trigger refetch of toilets
  void updateClusterById(int clusterId) {
    selectedCluster.value = clusters.firstWhere((cluster) => cluster.id == clusterId,
        orElse: () => Cluster(id: 0, clusterName: 'All Clusters', clusterCode: ''));
    fetchToilets();
  }
}
