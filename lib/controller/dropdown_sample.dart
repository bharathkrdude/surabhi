import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cluster_controller.dart';  // Import the controller

class ClusterDropdownPage extends StatelessWidget {
  final ClusterController clusterController = Get.put(ClusterController());  // Instantiate the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Cluster'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          // Display loading indicator while fetching data
          if (clusterController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          // Display dropdown with fetched cluster names
          return DropdownButton<int>(
            isExpanded: true,
            value: clusterController.clusters.isNotEmpty ? clusterController.clusters[0].id : null,
            onChanged: (int? newValue) {
              print('Selected cluster ID: $newValue');
            },
            items: clusterController.clusters.map((cluster) {
              return DropdownMenuItem<int>(
                value: cluster.id,
                child: Text(cluster.clusterName),
              );
            }).toList(),
          );
        }),
      ),
    );
  }
}
