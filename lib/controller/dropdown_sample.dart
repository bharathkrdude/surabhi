import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surabhi/controller/toilet/toilet_cotroller.dart';

import 'package:surabhi/model/toilet/cluster_model.dart';

class ClusterDropdown extends StatelessWidget {
  final ToiletController controller = Get.find<ToiletController>();

   ClusterDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButton<int>(
        value: controller.selectedCluster.value.id,
        onChanged: (int? newClusterId) {
          if (newClusterId != null) {
            controller.updateClusterById(newClusterId);
          }
        },
        items: controller.clusters.map((Cluster cluster) {
          return DropdownMenuItem<int>(
            value: cluster.id,
            child: Text(cluster.clusterName),
          );
        }).toList(),
      );
    });
  }
}
