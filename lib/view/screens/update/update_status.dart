import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:surabhi/controller/checklist/checklist_controller.dart';

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
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // First Image
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Obx(() => controller.images[0].value != null
              ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(controller.images[0].value!.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => controller.removeImage(0),
                      ),
                    ),
                  ],
                )
              : const Center(child: Text('No image selected'))),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => _pickImage(ImageSource.camera, 0),
          icon: const Icon(Icons.camera_alt),
          label: const Text('Take Picture 1'),
        ),

        const SizedBox(height: 16),

        // Second Image
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Obx(() => controller.images[1].value != null
              ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(controller.images[1].value!.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => controller.removeImage(1),
                      ),
                    ),
                  ],
                )
              : const Center(child: Text('No image selected'))),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => _pickImage(ImageSource.camera, 1),
          icon: const Icon(Icons.camera_alt),
          label: const Text('Take Picture 2'),
        ),

        const SizedBox(height: 16),

        // Third Image
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Obx(() => controller.images[2].value != null
              ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(controller.images[2].value!.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => controller.removeImage(2),
                      ),
                    ),
                  ],
                )
              : const Center(child: Text('No image selected'))),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => _pickImage(ImageSource.camera, 2),
          icon: const Icon(Icons.camera_alt),
          label: const Text('Take Picture 3'),
        ),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source, int index) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );
      if (image != null) {
        controller.setImage(index, File(image.path));
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
