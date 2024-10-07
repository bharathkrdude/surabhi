// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:surabhi/constants/colors.dart';
// import 'package:surabhi/controller/toilet/toilet_cotroller.dart';
// import 'package:surabhi/model/toilet/toilet_model.dart';
// import 'package:surabhi/view/screens/maintainanceDetail/widget/bookng_card_widget.dart';

// class ScreenMaintains extends StatelessWidget {
//   final ToiletController toiletController = Get.put(ToiletController());

//   ScreenMaintains({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Maintenance'),
//         backgroundColor: primaryButton,
//       ),
//       body: Obx(() {
//         print('Rebuilding ScreenMaintain');
//       print('isLoading: ${toiletController.isLoading.value}');
//       print('toilets count: ${toiletController.toilets.length}');
//       if (toiletController.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       } else if (toiletController.toilets.isEmpty) {
//         return const Center(child: Text('No toilets available'));
//       }  else {
//           return RefreshIndicator(
//             onRefresh: () async => toiletController.fetchToilets(),
//             child: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.75,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//               ),
//               padding: const EdgeInsets.all(16),
//               itemCount: toiletController.toilets.length,
//               itemBuilder: (context, index) {
//                 var toilet = toiletController.toilets[index];
//                 return GestureDetector(
//                   onTap: () => _showPopup(context, toilet),
//                   child: ToiletCard(toilet: toilet),
//                 );
//               },
//             ),
//           );
//         }
//       }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => toiletController.fetchToilets(),
//         child: const Icon(Icons.refresh),
//         backgroundColor: primaryButton,
//       ),
//     );
//   }

//   void _showPopup(BuildContext context, Toilet toilet) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           contentPadding: EdgeInsets.zero,
//           content: BookingCard(toilet: toilet),
//         );
//       },
//     );
//   }
// }

// class ToiletCard extends StatelessWidget {
//   final Toilet toilet;

//   const ToiletCard({Key? key, required this.toilet}) : super(key: key);

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
//                     toilet.toiletCode,
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   Expanded(
//                     child: Image.asset(
//                       "assets/images/toilet.png",
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Rating: ${toilet.rating.toStringAsFixed(1)}',
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             decoration: BoxDecoration(
//               color: toilet.toiletStatus == 'pending' ? Colors.red : Colors.green,
//               borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
//             ),
//             child: Text(
//               toilet.toiletStatus,
//               textAlign: TextAlign.center,
//               style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
//   }
// }
