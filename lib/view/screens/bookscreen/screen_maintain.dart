import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/controller/toilet/toilet_cotroller.dart';
import 'package:surabhi/model/toilet/toilet_model.dart';
import 'package:surabhi/view/screens/login/widgets/textbutton_widget.dart';
import 'package:surabhi/view/screens/maintainanceDetail/widget/bookng_card_widget.dart';

class ScreenMaintain extends StatelessWidget {
  final ToiletController toiletController = Get.put(ToiletController());

  ScreenMaintain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorgrey,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButtonWidget(
                  onPressed: () {
                    _showFilterBottomSheet(); // Show the bottom sheet when filter button is pressed
                  },
                  text: "Filter",
                ),
              ),
            ),
            Expanded(
              child:StreamBuilder<List<ToiletModel>>(
  stream: toiletController.filteredToiletsStream,
  builder: (context, snapshot) {
    if (toiletController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Center(child: Text("No toilets available"));
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(16),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          var toilet = snapshot.data![index];
          return GestureDetector(
            onTap: () => _showPopup(context, index),
            child: CustomContainerWithMark(
              toiletCode: toilet.toiletCode,
              isChecked: toilet.toiletStatus == 'completed',
            ),
          );
        },
      );
    }
  },
)

            ),
          ],
        ),
      ),
    );
  }

  // Function to display filter options in a bottom sheet
void _showFilterBottomSheet() {
  final theme = Get.theme;
  final primaryColor = theme.primaryColor;
  final accentColor = theme.actionIconTheme;

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

          // Section: Cluster Selection
          _buildSectionTitle("Select Cluster"),
          SizedBox(height: 12),
          Obx(() {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: toiletController.selectedCluster.value,
                hint: Text("Choose a cluster"),
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down, color: primaryColor),
                underline: SizedBox(),
                items: [
                  DropdownMenuItem<String>(
                    value: '', // Represents "All" clusters as an empty string
                    child: Text("All Clusters"),
                  ),
                  ...toiletController.clusters.map((cluster) {
                    return DropdownMenuItem<String>(
                      value: cluster.clusterCode,
                      child: Text(cluster.clusterName),
                    );
                  }).toList(),
                ],
                onChanged: (value) {
                  toiletController.setSelectedCluster(value);
                },
              ),
            );
          }),
          SizedBox(height: 24),

          // Section: Status Selection
          _buildSectionTitle("Status"),
          SizedBox(height: 12),
          Obx(() {
            return Column(
              children: [
                _buildCustomRadioTile(
                  title: 'Completed',
                  value: 'completed',
                  groupValue: toiletController.selectedStatus.value,
                  onChanged: (value) {
                    toiletController.setSelectedStatus(value);
                  },
                  icon: Icons.check_circle,
                ),
                SizedBox(height: 8),
                _buildCustomRadioTile(
                  title: 'Pending',
                  value: 'pending',
                  groupValue: toiletController.selectedStatus.value,
                  onChanged: (value) {
                    toiletController.setSelectedStatus(value);
                  },
                  icon: Icons.pending,
                ),
              ],
            );
          }),

          SizedBox(height: 32),

          // Buttons for Clear Filters and Apply Filters
          Row(
            children: [
              // Clear Filters Button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    toiletController.clearFilters(); // Clear the filters
                    Get.back();
                  },
                  icon: Icon(Icons.clear),
                  label: Text('Clear Filters'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black87, backgroundColor: Colors.grey[300],
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              
              // Apply Filters Button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.back();
                    toiletController.fetchFilteredToilets(); // Fetch toilets with applied filters
                  },
                  icon: Icon(Icons.filter_list),
                  label: Text('Apply Filters'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
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


  // Show the details of a specific toilet in a popup
  void _showPopup(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: BookingCard(toilet: toiletController.toilets[index]),
        );
      },
    );
  }
}



class CustomContainerWithMark extends StatelessWidget {
  final String toiletCode;
  final bool isChecked;

  const CustomContainerWithMark({
    super.key,
    required this.toiletCode,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    toiletCode,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                  Expanded(
                    child: Image.asset(
                      "assets/images/toilet.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: isChecked ? Colors.green : Colors.red,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            child: Text(
              isChecked ? 'Completed' : 'Pending',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}