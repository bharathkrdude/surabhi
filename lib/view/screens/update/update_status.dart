import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surabhi/constants/colors.dart';
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: 3,
          itemBuilder: (context, index) => _buildImageCard(index, context),
        ),
      ),
    );
  }

  Widget _buildImageCard(int index, BuildContext context) {
    return Card(
      surfaceTintColor: Colors.grey,
      elevation: 3,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Obx(() => controller.images[index].value != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Image.file(
                            File(controller.images[index].value!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Material(
                            color: Colors.white.withOpacity(0.9),
                            shape: const CircleBorder(),
                            child: IconButton(
                              icon: Icon(Icons.close, 
                                color: Colors.red.shade400,
                                size: 22,
                              ),
                              onPressed: () => controller.removeImage(index),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                    width: double.infinity,
                      decoration: BoxDecoration(
                        color: secondary,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: Icon(
                        Icons.add_photo_alternate_rounded,
                        size: 45,
                        color: Colors.grey.shade400,
                      ),
                    )),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(16),
                        ),
              color: white
            ),
            
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // IconButton(
                //   icon: Icon(Icons.photo_library_rounded,
                //     color: Theme.of(context).primaryColor,
                //   ),
                //   onPressed: () => _pickImage(ImageSource.gallery, index),
                //   tooltip: 'Choose from gallery',
                // ),
                IconButton(
                  icon: Icon(Icons.camera_alt_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => _pickImage(ImageSource.camera, index),
                  tooltip: 'Take a photo',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source, int index) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(
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
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red.shade900,
        duration: const Duration(seconds: 3),
        borderRadius: 8,
        margin: const EdgeInsets.all(16),
      );
    }
  }
}