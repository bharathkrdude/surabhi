import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/controller/toilet/toilet_cotroller.dart';
import 'package:surabhi/model/cheklist/checklist_screen.dart';
import 'package:surabhi/model/toilet/cluster_model.dart';
import 'package:surabhi/view/screens/login/widgets/textbutton_widget.dart';
import 'package:surabhi/view/screens/main/widgets/custom_app_bar.dart';
import 'package:surabhi/view/screens/maintainanceDetail/widget/toilet_card_widget.dart';

class Toilet {
  final int id;
  final String toiletCode;
  final double rating;
  final String toiletStatus;

  Toilet(
      {required this.id,
      required this.toiletCode,
      required this.rating,
      required this.toiletStatus});

  factory Toilet.fromJson(Map<String, dynamic> json) {
    return Toilet(
      id: json['id'],
      toiletCode: json['toilet_code'],
      rating: json['rating'].toDouble(),
      toiletStatus: json['toilet_status'],
    );
  }
}

class ScreenToilet extends StatelessWidget {
  final ToiletController toiletController = Get.put(ToiletController());

  ScreenToilet({super.key});

  @override
  Widget build(BuildContext context) {
    toiletController.fetchToilets(initialFetch: true);
    toiletController.fetchClusters();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Toilets',
        actions: [
          TextButtonWidget(
              onPressed: () {
                showFilterBottomSheet();
              },
              text: '')
        ],
      ),
      backgroundColor: Colors.grey[
          200], // You can replace this with your backgroundColorgrey variable
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() {
                  if (toiletController.isLoading.value) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: secondary,
                    ));
                  } else if (toiletController.toilets.isEmpty) {
                    return const Center(
                        child: Text(
                            'No toilets found. Try adjusting your filters.'));
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      padding: const EdgeInsets.all(8),
                      itemCount: toiletController.toilets.length,
                      itemBuilder: (context, index) {
                        final toilet = toiletController.toilets[index];
                        return GestureDetector(
                          onTap: () => Get.to(ChecklistScreen(
                            toiletId: toilet.id,
                          )),
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
            ),
          ],
        ),
      ),
    );
  }

  void showFilterBottomSheet() {
    final theme = Get.theme;
    final primaryColor = theme.primaryColor;

    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              "Filter Options",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 24),
            _sectionTitle("Select Cluster"),
            const SizedBox(height: 12),
            Obx(() {
              if (toiletController.isLoading.value) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.green,
                )); // Show loading indicator
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
            const SizedBox(height: 24),
            _sectionTitle("Status"),
            const SizedBox(height: 12),
            _statusRadioButtons(),
            const SizedBox(height: 32),
            _filterButtons(primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _statusRadioButtons() {
    return Obx(() => Column(
          children: [
            _customRadioTile(
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
            _customRadioTile(
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
            _customRadioTile(
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

  Widget _filterButtons(Color primaryColor) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              toiletController.selectedCluster.value =
                  Cluster(id: 0, clusterName: 'All Clusters', clusterCode: '');
              toiletController.selectedStatus.value = 'All';
              toiletController.fetchToilets();
              Get.back();
            },
            icon: const Icon(Icons.clear),
            label: const Text('Clear Filters'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black87,
              backgroundColor: Colors.grey[300],
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              toiletController.fetchToilets();
              Get.back();
            },
            icon: const Icon(Icons.filter_list),
            label: const Text('Apply Filters'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: primaryButton,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _customRadioTile({
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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Get.theme.primaryColor : Colors.black87,
              ),
            ),
            const Spacer(),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
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
            Text('Toilet Code: ${toilet.toiletCode}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Status: ${toilet.toiletStatus}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Rating: ${toilet.rating}',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
