// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:surabhi/constants/colors.dart';
// // import 'package:surabhi/controller/toilet/toilet_cotroller.dart';
// // import 'package:surabhi/view/screens/login/widgets/textbutton_widget.dart';
// // import 'package:surabhi/view/screens/maintainanceDetail/widget/bookng_card_widget.dart';

// // class ScreenMaintain extends StatelessWidget {
// //   final ToiletController toiletController = Get.put(ToiletController());

// //   ScreenMaintain({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: backgroundColorgrey,
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: Align(
// //                 alignment: Alignment.centerRight,
// //                 child: TextButtonWidget(
// //                   onPressed: _showFilterBottomSheet,
// //                   text: "Filter",
// //                 ),
// //               ),
// //             ),
// //             Expanded(
// //               child: Obx(() {
// //                 if (toiletController.isLoading.value) {
// //                   return const Center(child: CircularProgressIndicator());
// //                 } else if (toiletController.toilets.isEmpty) {
// //                   return const Center(child: Text("No toilets available"));
// //                 } else {
// //                   return GridView.builder(
// //                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                       crossAxisCount: 4,
// //                       childAspectRatio: 0.8,
// //                       crossAxisSpacing: 10,
// //                       mainAxisSpacing: 10,
// //                     ),
// //                     padding: const EdgeInsets.all(16),
// //                     itemCount: toiletController.toilets.length,
// //                     itemBuilder: (context, index) {
// //                       var toilet = toiletController.toilets[index];
// //                       return GestureDetector(
// //                         onTap: () => _showPopup(context, toilet),
// //                         child: CustomContainerWithMark(
// //                           toiletCode: toilet.toiletCode,
// //                           isChecked: toilet.toiletStatus == 'completed',
// //                         ),
// //                       );
// //                     },
// //                   );
// //                 }
// //               }),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   void _showFilterBottomSheet() {
// //     final theme = Get.theme;
// //     final primaryColor = theme.primaryColor;

// //     Get.bottomSheet(
// //       Container(
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.grey.withOpacity(0.5),
// //               spreadRadius: 5,
// //               blurRadius: 7,
// //               offset: Offset(0, 3),
// //             ),
// //           ],
// //         ),
// //         child: ListView(
// //           padding: EdgeInsets.all(24),
// //           children: [
// //             Text(
// //               "Filter Options",
// //               style: TextStyle(
// //                 fontSize: 24,
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.black,
// //                 letterSpacing: 0.5,
// //               ),
// //             ),
// //             SizedBox(height: 24),

// //             _buildSectionTitle("Select Cluster"),
// //             SizedBox(height: 12),
// //             _buildClusterDropdown(primaryColor),
// //             SizedBox(height: 24),

// //             _buildSectionTitle("Status"),
// //             SizedBox(height: 12),
// //             _buildStatusRadioButtons(),

// //             SizedBox(height: 32),

// //             _buildFilterButtons(primaryColor),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildClusterDropdown(Color primaryColor) {
// //     return Obx(() {
// //       return Container(
// //         padding: EdgeInsets.symmetric(horizontal: 12),
// //         decoration: BoxDecoration(
// //           border: Border.all(color: primaryColor),
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //         child: DropdownButton<String>(
// //           value: toiletController.selectedCluster.value.isEmpty
// //               ? null
// //               : toiletController.selectedCluster.value,
// //           hint: Text("Choose a cluster"),
// //           isExpanded: true,
// //           icon: Icon(Icons.arrow_drop_down, color: primaryColor),
// //           underline: SizedBox(),
// //           items: [
// //             DropdownMenuItem<String>(
// //               value: '',
// //               child: Text("All Clusters"),
// //             ),
// //             ...toiletController.clusters.map((cluster) {
// //               return DropdownMenuItem<String>(
// //                 value: cluster.clusterCode,
// //                 child: Text(cluster.clusterName),
// //               );
// //             }).toList(),
// //           ],
// //           onChanged: toiletController.setSelectedCluster,
// //         ),
// //       );
// //     });
// //   }

// //   Widget _buildStatusRadioButtons() {
// //     return Obx(() {
// //       return Column(
// //         children: [
// //           _buildCustomRadioTile(
// //             title: 'Completed',
// //             value: 'completed',
// //             groupValue: toiletController.selectedStatus.value,
// //             onChanged: toiletController.setSelectedStatus,
// //             icon: Icons.check_circle,
// //           ),
// //           SizedBox(height: 8),
// //           _buildCustomRadioTile(
// //             title: 'Pending',
// //             value: 'pending',
// //             groupValue: toiletController.selectedStatus.value,
// //             onChanged: toiletController.setSelectedStatus,
// //             icon: Icons.pending,
// //           ),
// //         ],
// //       );
// //     });
// //   }

// //   Widget _buildFilterButtons(Color primaryColor) {
// //     return Row(
// //       children: [
// //         Expanded(
// //           child: ElevatedButton.icon(
// //             onPressed: () {
// //               toiletController.clearFilters();  // Clears selected filters
// //               toiletController.fetchToilets();  // Re-fetch without filters
// //               Get.back();
// //             },
// //             icon: Icon(Icons.clear),
// //             label: Text('Clear Filters'),
// //             style: ElevatedButton.styleFrom(
// //               foregroundColor: Colors.black87,
// //               backgroundColor: Colors.grey[300],
// //               padding: EdgeInsets.symmetric(vertical: 12),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(8),
// //               ),
// //             ),
// //           ),
// //         ),
// //         SizedBox(width: 16),
// //         Expanded(
// //           child: ElevatedButton.icon(
// //             onPressed: () {
// //               toiletController.fetchToilets(applyFilters: true);  // Fetch with filters
// //               Get.back();  // Close bottom sheet
// //             },
// //             icon: Icon(Icons.filter_list),
// //             label: Text('Apply Filters'),
// //             style: ElevatedButton.styleFrom(
// //               foregroundColor: Colors.white,
// //               backgroundColor: primaryColor,
// //               padding: EdgeInsets.symmetric(vertical: 12),
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(8),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildSectionTitle(String title) {
// //     return Text(
// //       title,
// //       style: TextStyle(
// //         fontSize: 18,
// //         fontWeight: FontWeight.bold,
// //         color: Colors.black,
// //       ),
// //     );
// //   }

// //   Widget _buildCustomRadioTile({
// //     required String title,
// //     required String value,
// //     required String? groupValue,
// //     required Function(String?) onChanged,
// //     required IconData icon,
// //   }) {
// //     final isSelected = value == groupValue;
// //     final color = isSelected ? Get.theme.primaryColor : Colors.grey;

// //     return InkWell(
// //       onTap: () => onChanged(value),
// //       child: Container(
// //         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
// //         decoration: BoxDecoration(
// //           border: Border.all(color: color),
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //         child: Row(
// //           children: [
// //             Icon(icon, color: color),
// //             SizedBox(width: 12),
// //             Text(
// //               title,
// //               style: TextStyle(
// //                 fontSize: 16,
// //                 color: isSelected ? Get.theme.primaryColor : Colors.black87,
// //               ),
// //             ),
// //             Spacer(),
// //             Icon(
// //               isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
// //               color: color,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   void _showPopup(BuildContext context, Toilet toilet) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           contentPadding: EdgeInsets.zero,
// //           content: BookingCard(toilet: toilet),
// //         );
// //       },
// //     );
// //   }
// // }

// // class CustomContainerWithMark extends StatelessWidget {
// //   final String toiletCode;
// //   final bool isChecked;

// //   const CustomContainerWithMark({
// //     Key? key,
// //     required this.toiletCode,
// //     required this.isChecked,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       elevation: 2,
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// //       child: Column(
// //         children: [
// //           Expanded(
// //             child: Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Text(
// //                     toiletCode,
// //                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
// //                   ),
// //                   Expanded(
// //                     child: Image.asset(
// //                       "assets/images/toilet.png",
// //                       fit: BoxFit.contain,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           Container(
// //             width: double.infinity,
// //             padding: const EdgeInsets.symmetric(vertical: 4),
// //             decoration: BoxDecoration(
// //               color: isChecked ? Colors.green : Colors.red,
// //               borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
// //             ),
// //             child: Text(
// //               isChecked ? 'Completed' : 'Pending',
// //               textAlign: TextAlign.center,
// //               style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }



// ///second temp option



// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:surabhi/controller/toilet/toilet_cotroller.dart';

// // class ScreenMaintain extends StatelessWidget {
// //   final ToiletController toiletController = Get.put(ToiletController());

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Toilets')),
// //       body: Obx(() {
// //         if (toiletController.isLoading.value) {
// //           return Center(child: CircularProgressIndicator());
// //         }
// //         if (toiletController.toilets.isEmpty) {
// //           return Center(child: Text('No toilets available.'));
// //         }
// //         return ListView.builder(
// //           itemCount: toiletController.toilets.length,
// //           itemBuilder: (context, index) {
// //             final toilet = toiletController.toilets[index];
// //             return Card(
// //               margin: EdgeInsets.all(8.0),
// //               child: ListTile(
// //                 title: Text('Toilet Code: ${toilet.toiletCode}'),
// //                 subtitle: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text('Rating: ${toilet.rating}'),
// //                     Text('Status: ${toilet.toiletStatus}'),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       }),
// //     );
// //   }
// // }



// //last updated

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:surabhi/constants/colors.dart';
// import 'package:surabhi/model/cheklist/complaint_model.dart';
// import 'package:surabhi/view/screens/login/widgets/textbutton_widget.dart';
// import 'package:surabhi/view/screens/maintainanceDetail/widget/toilet_card_widget.dart';
// import 'package:surabhi/view/screens/test/testDelete.dart';

// import '../../../controller/toilet/toilet_cotroller.dart';

// class ScreenMaintain extends StatelessWidget {
//    ScreenMaintain({super.key});
//  final ToiletController toiletController = Get.put(ToiletController());

//   @override
//   Widget build(BuildContext context) {
//     toiletController.fetchToilets(initialFetch: true);
//     return Scaffold(
//       backgroundColor: Colors.grey[200],  // You can replace this with your backgroundColorgrey variable
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButtonWidget(onPressed: _showFilterBottomSheet, text: 'Filter'),
//               ),
//             ),
//             Expanded(
//               child: Obx(() {
//                 if (toiletController.isLoading.value) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (toiletController.toilets.isEmpty) {
//                   return Center(child: Text('No toilets found. Try adjusting your filters.'));
//                 } else {
//                   return GridView.builder(
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 4,
//                       childAspectRatio: 0.8,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                     ),
//                     padding: const EdgeInsets.all(16),
//                     itemCount: toiletController.toilets.length,
//                     itemBuilder: (context, index) {
//                       final toilet = toiletController.toilets[index];
//                       return GestureDetector(
//                         onTap: () => Get.to(ChecklistScreen(toiletId: toilet.id, toiletCode: toilet.toiletCode,)),
//                         child: ToiletCardWidget(
//                           toiletCode: toilet.toiletCode,
//                           isChecked: toilet.toiletStatus != 'pending',
//                         ),
//                       );
//                     },
//                   );
//                 }
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }



//   void _showFilterBottomSheet() {
//     final theme = Get.theme;
//     final primaryColor = theme.primaryColor;

//     Get.bottomSheet(
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: ListView(
//           padding: EdgeInsets.all(24),
//           children: [
//             Text(
//               "Filter Options",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//                 letterSpacing: 0.5,
//               ),
//             ),
//             SizedBox(height: 24),
//             _buildSectionTitle("Select Cluster"),
//             SizedBox(height: 12),
//            ClusterDropdown(
//               onChanged: (int? selectedClusterId) {
//                 // Handle the selected cluster ID here
//                 print('Selected Cluster ID: $selectedClusterId');
//               },
//             ),
//             SizedBox(height: 24),
//             _buildSectionTitle("Status"),
//             SizedBox(height: 12),
//             _buildStatusRadioButtons(),
//             SizedBox(height: 32),
//             _buildFilterButtons(primaryColor),
//           ],
//         ),
//       ),
//     );
//   }
// Widget _buildClusterDropdown(Color primaryColor) {
//   return Obx(() => Container(
//     padding: EdgeInsets.symmetric(horizontal: 12),
//     decoration: BoxDecoration(
//       border: Border.all(color: primaryColor),
//       borderRadius: BorderRadius.circular(8),
//     ),
//     child: DropdownButton<Cluster>(
//       value: toiletController.selectedCluster.value,
//       hint: Text("Choose a cluster"),
//       isExpanded: true,
//       icon: Icon(Icons.arrow_drop_down, color: primaryColor),
//       underline: SizedBox(),
//       items: toiletController.clusters.map((Cluster cluster) {
//         return DropdownMenuItem<Cluster>(
//           value: cluster,
//           child: Text(cluster.clusterName),  // Use cluster name for display
//         );
//       }).toList(),
//       onChanged: (Cluster? value) {
//         if (value != null) {
//           toiletController.updateCluster(value);
//           Get.back();  // Close the dropdown
//         }
//       },
//     ),
//   ));
// }


//   Widget _buildStatusRadioButtons() {
//     return Obx(() => Column(
//       children: [
//         _buildCustomRadioTile(
//           title: 'All',
//           value: 'All',
//           groupValue: toiletController.selectedStatus.value,
//           onChanged: (value) {
//             toiletController.updateStatus(value!);
//             Get.back();
//           },
//           icon: Icons.all_inclusive,
//         ),
//         SizedBox(height: 8),
//         _buildCustomRadioTile(
//           title: 'Completed',
//           value: 'Completed',
//           groupValue: toiletController.selectedStatus.value,
//           onChanged: (value) {
//             toiletController.updateStatus(value!);
//             Get.back();
//           },
//           icon: Icons.check_circle,
//         ),
//         SizedBox(height: 8),
//         _buildCustomRadioTile(
//           title: 'Pending',
//           value: 'Pending',
//           groupValue: toiletController.selectedStatus.value,
//           onChanged: (value) {
//             toiletController.updateStatus(value!);
//             Get.back();
//           },
//           icon: Icons.pending,
//         ),
//       ],
//     ));
//   }

//   Widget _buildFilterButtons(Color primaryColor) {
//     return Row(
//       children: [
//         Expanded(
//           child: ElevatedButton.icon(
//             onPressed: () {
//               toiletController.selectedCluster.value = Cluster(id: 0, clusterName: 'All Clusters', clusterCode: '');
//               toiletController.selectedStatus.value = 'All';
//               toiletController.fetchToilets();
//               Get.back();
//             },
//             icon: Icon(Icons.clear),
//             label: Text('Clear Filters'),
//             style: ElevatedButton.styleFrom(
//               foregroundColor: Colors.black87,
//               backgroundColor: Colors.grey[300],
//               padding: EdgeInsets.symmetric(vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: ElevatedButton.icon(
//             onPressed: () {
//               toiletController.fetchToilets();
//               Get.back();
//             },
//             icon: Icon(Icons.filter_list),
//             label: Text('Apply Filters'),
//             style: ElevatedButton.styleFrom(
//               foregroundColor: Colors.white,
//               backgroundColor: primaryButton,
//               padding: EdgeInsets.symmetric(vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//         color: Colors.black,
//       ),
//     );
//   }

//   Widget _buildCustomRadioTile({
//     required String title,
//     required String value,
//     required String? groupValue,
//     required Function(String?) onChanged,
//     required IconData icon,
//   }) {
//     final isSelected = value == groupValue;
//     final color = isSelected ? Get.theme.primaryColor : Colors.grey;

//     return InkWell(
//       onTap: () => onChanged(value),
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         decoration: BoxDecoration(
//           border: Border.all(color: color),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, color: color),
//             SizedBox(width: 12),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: isSelected ? Get.theme.primaryColor : Colors.black87,
//               ),
//             ),
//             Spacer(),
//             Icon(
//               isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
//               color: color,
//             ),
//           ],
//         ),
//       ),
//     );
//   }




// }

// class CustomContainerWithMark extends StatelessWidget {
//   final String toiletCode;
//   final bool isChecked;

//   const CustomContainerWithMark({
//     super.key,
//     required this.toiletCode,
//     required this.isChecked,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Column(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     toiletCode,
//                     style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
//                   ),
//                   Expanded(
//                     child: Image.asset(
//                       "assets/images/toilet.png",
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 4),
//             decoration: BoxDecoration(
//               color: isChecked ? Colors.green : Colors.red,
//               borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
//             ),
//             child: Text(
//               isChecked ? 'Completed' : 'Pending',
//               textAlign: TextAlign.center,
//               style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }





  

// }

