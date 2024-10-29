import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:surabhi/controller/checklist/checklist_controller.dart';
import 'package:surabhi/view/widgets/primary_button_widget.dart';

// class UpdateStatusPage extends StatelessWidget {
//   final String initialStatus;
//   final String initialImagePath;
//   final ChecklistController _controller;

//   UpdateStatusPage({
//     Key? key, 
//     required this.initialStatus, 
//     required this.initialImagePath,
//   }) : _controller = Get.put(ChecklistController()),
//        super(key: key) {
//     // Initialize controller with initial values
//     _controller.selectedStatus.value = initialStatus;
//     if (initialImagePath.isNotEmpty) {
//       _controller.image.value = File(initialImagePath);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Update Status'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               ImagePickerWidget(controller: _controller),
//               const SizedBox(height: 20),
//               Obx(() => DropdownButtonFormField<String>(
//                 value: _controller.selectedStatus.value,
//                 decoration: const InputDecoration(
//                   labelText: 'Status',
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 ),
//                 items: ['pending', 'completed'].map((String status) {
//                   return DropdownMenuItem<String>(
//                     value: status,
//                     child: Text(status.capitalize ?? status),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   if (newValue != null) {
//                     _controller.updateStatus(newValue);
//                   }
//                 },
//               )),
//               const SizedBox(height: 24),
//               PrimaryButtonWidget(
//                 title: "Submit",
//                 onPressed: () {
//                   if (_controller.image.value == null) {
//                     Get.snackbar(
//                       'Error', 
//                       'Please select an image',
//                       snackPosition: SnackPosition.BOTTOM,
//                     );
//                     return;
//                   }
//                   _controller.;
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ImagePickerWidget extends StatelessWidget {
  final ChecklistController controller;

  const ImagePickerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Obx(() => controller.image.value != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(controller.image.value!.path),
                    fit: BoxFit.cover,
                  ),
                )
              : const Center(child: Text('No image selected'))),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take Picture'),
            ),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.photo_library),
              label: const Text('Gallery'),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );
      if (image != null) {
        controller.image.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
