import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/controller/toilet/toilet_cotroller.dart';
import 'package:surabhi/model/cheklist/complaint_model.dart';
import 'package:surabhi/model/toilet/cluster_model.dart';
import 'package:surabhi/view/screens/login/widgets/textbutton_widget.dart';
import 'package:surabhi/view/screens/main/widgets/custom_app_bar.dart';
import 'package:surabhi/view/screens/maintainanceDetail/widget/toilet_card_widget.dart';

// class Cluster {
//   final int id;
//   final String clusterName;
//   final String clusterCode;

//   Cluster({required this.id, required this.clusterName, required this.clusterCode});

//   factory Cluster.fromJson(Map<String, dynamic> json) {
//     return Cluster(
//       id: json['id'],
//       clusterName: json['cluster_name'],
//       clusterCode: json['cluster_code'],
//     );
//   }
// }

class Toilet {
  final int id;
  final String toiletCode;
  final double rating;
  final String toiletStatus;

  Toilet({required this.id, required this.toiletCode, required this.rating, required this.toiletStatus});

  factory Toilet.fromJson(Map<String, dynamic> json) {
    return Toilet(
      id: json['id'],
      toiletCode: json['toilet_code'],
      rating: json['rating'].toDouble(),
      toiletStatus: json['toilet_status'],
    );
  }
}
 // Import the controller

// class ClusterDropdown extends StatelessWidget {
//   // final ClusterController clusterController = Get.put(ClusterController());  // Instantiate the controller
//   final Function(int?) onChanged; // Callback to handle selection

//   ClusterDropdown({required this.onChanged}); // Constructor to accept callback

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       // Display loading indicator while fetching data
//       if (clusterController.isLoading.value) {
//         return Center(child: CircularProgressIndicator());
//       }

//       // Check if clusters are loaded and not empty
//       if (clusterController.clusters.isEmpty) {
//         return Text("No clusters available");
//       }

//       // Display dropdown with fetched cluster names
//       return DropdownButton<int>(
//         isExpanded: true,
//         value: clusterController.clusters.isNotEmpty ? clusterController.clusters[0].id : null,
//         onChanged: (int? newValue) {
//           print('Selected cluster ID: $newValue');
//           onChanged(newValue); // Call the provided callback with the selected value
//         },
//         items: clusterController.clusters.map((cluster) {
//           return DropdownMenuItem<int>(
//             value: cluster.id,
//             child: Text(cluster.clusterName),
//           );
//         }).toList(),
//       );
//     });
//   }
// }


class ScreenMaintainTest extends StatelessWidget {
  final ToiletController toiletController = Get.put(ToiletController());

 ScreenMaintainTest({super.key});
 
  @override
  Widget build(BuildContext context) {
    toiletController.fetchToilets(initialFetch: true);
    toiletController.fetchClusters();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Toilets'),
      backgroundColor: Colors.grey[200],  // You can replace this with your backgroundColorgrey variable
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButtonWidget(onPressed: _showFilterBottomSheet, text: 'Filter'),
              ),
            ),
            Expanded(
              child: Obx(() {
                
                if (toiletController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (toiletController.toilets.isEmpty) {
                  return Center(child: Text('No toilets found. Try adjusting your filters.'));
                } else {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    padding: const EdgeInsets.all(16),
                    itemCount: toiletController.toilets.length,
                    itemBuilder: (context, index) {
                      final toilet = toiletController.toilets[index];
                      return GestureDetector(
                        onTap: () => Get.to(ChecklistScreen(toiletId: toilet.id, toiletCode: toilet.toiletCode,)),
                        child: ToiletCardWidget(
                          toiletCode: toilet.toiletCode,
                          isChecked: toilet.toiletStatus != 'pending',
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    final theme = Get.theme;
    final primaryColor = theme.primaryColor;
   
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            Text(
              "Filter Options",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 24),
            _buildSectionTitle("Select Cluster"),
            SizedBox(height: 12),
          Obx(() {
            if (toiletController.isLoading.value) {
              return Center(child: CircularProgressIndicator());  // Show loading indicator
            }

            return DropdownButton<int>(
              value: toiletController.selectedCluster.value.id,
              onChanged: (int? newClusterId) {
                if (newClusterId != null) {
                  toiletController.updateClusterById(newClusterId);
                  // Optionally, close the bottom sheet
                  Get.back();
                }
              },
              items: toiletController.clusters.map((Cluster cluster) {
                return DropdownMenuItem<int>(
                  value: cluster.id,
                  child: Text(cluster.clusterName),
                );
              }).toList(),
            );
          }),

            SizedBox(height: 24),
            _buildSectionTitle("Status"),
            SizedBox(height: 12),
            _buildStatusRadioButtons(),
            SizedBox(height: 32),
            _buildFilterButtons(primaryColor),
          ],
        ),
      ),
    );
  }
  Widget _buildClusterDropdown(Color primaryColor) {
  return Obx(() => Container(
    padding: EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      border: Border.all(color: primaryColor),
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButton<int>(
      value: toiletController.selectedCluster.value.id,  // Use selectedCluster's ID
      hint: Text("Choose a cluster"),
      isExpanded: true,
      icon: Icon(Icons.arrow_drop_down, color: primaryColor),
      underline: SizedBox(),
      items: toiletController.clusters.map((Cluster cluster) {
        return DropdownMenuItem<int>(
          value: cluster.id,  // Set the cluster ID as value
          child: Text(cluster.clusterName),  // Display cluster name
        );
      }).toList(),
      onChanged: (int? clusterId) {
        if (clusterId != null) {
          toiletController.updateClusterById(clusterId);  // Update selected cluster by ID
          Get.back();  // Close the dropdown
        }
      },
    ),
  ));
}



  Widget _buildStatusRadioButtons() {
    return Obx(() => Column(
      children: [
        _buildCustomRadioTile(
          title: 'All',
          value: 'All',
          groupValue: toiletController.selectedStatus.value,
          onChanged: (value) {
            toiletController.updateStatus(value!);
            // Get.back();
          },
          icon: Icons.all_inclusive,
        ),
        const SizedBox(height: 8),
        _buildCustomRadioTile(
          title: 'Completed',
          value: 'Completed',
          groupValue: toiletController.selectedStatus.value,
          onChanged: (value) {
            toiletController.updateStatus(value!);
            // Get.back();
          },
          icon: Icons.check_circle,
        ),
        const SizedBox(height: 8),
        _buildCustomRadioTile(
          title: 'Pending',
          value: 'Pending',
          groupValue: toiletController.selectedStatus.value,
          onChanged: (value) {
            toiletController.updateStatus(value!);
            // Get.back();
          },
          icon: Icons.pending,
        ),
      ],
    ));
  }

  Widget _buildFilterButtons(Color primaryColor) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              toiletController.selectedCluster.value = Cluster(id: 0, clusterName: 'All Clusters', clusterCode: '');
              toiletController.selectedStatus.value = 'All';
              toiletController.fetchToilets();
              Get.back();
            },
            icon: Icon(Icons.clear),
            label: Text('Clear Filters'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black87,
              backgroundColor: Colors.grey[300],
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              toiletController.fetchToilets();
           Get.back();
            },
            icon: Icon(Icons.filter_list),
            label: Text('Apply Filters'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: primaryButton,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildCustomRadioTile({
    required String title,
    required String value,
    required String? groupValue,
    required Function(String?) onChanged,
    required IconData icon,
  }) {
    final isSelected = value == groupValue;
    final color = isSelected ? Get.theme.primaryColor : Colors.grey;

    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Get.theme.primaryColor : Colors.black87,
              ),
            ),
            Spacer(),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

}


class BookingCard extends StatelessWidget {
  final Toilet toilet;

  const BookingCard({super.key, required this.toilet});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Toilet Code: ${toilet.toiletCode}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Status: ${toilet.toiletStatus}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Rating: ${toilet.rating}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
