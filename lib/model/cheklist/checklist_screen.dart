import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/controller/checklist/checklist_controller.dart';
import 'package:surabhi/view/screens/update/update_status.dart';
import 'package:surabhi/view/widgets/primary_button_widget.dart';

class ChecklistScreen extends StatefulWidget {
  final int toiletId;
  const ChecklistScreen({
    super.key,
    required this.toiletId,
  });

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  String _selectedStatus = 'pending';
  final List<String> _statusOptions = ['pending', 'completed'];
  final ChecklistController checklistController =
      Get.put(ChecklistController());

  @override
  void initState() {
    super.initState();
    checklistController.fetchChecklistData(widget.toiletId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorlightgrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryButton,
        title: const Text(
          'Update Checklist',
          style: TextStyle(
            color: white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Obx(() => Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.qr_code,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      checklistController.toiletCode.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              )),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.8),
              ],
            ),
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Obx(() {
        if (checklistController.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: secondary,
          ));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Checklist Questions Section
                const Text(
                  'Checklist Questions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ...checklistController.checklists.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final checklist = entry.value;
                  return Card(
                    surfaceTintColor: white,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ${checklist.checkListName}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () =>
                                    checklistController.updateChecklistAnswer(
                                  index: checklist.id,
                                  value: "yes",
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: checklistController
                                                  .checklistAnswers[
                                              "checklist[${checklist.id}]"] ==
                                          "yes"
                                      ? Colors.green
                                      : Colors.grey,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: () =>
                                    checklistController.updateChecklistAnswer(
                                  index: checklist.id,
                                  value: "no",
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: checklistController
                                                  .checklistAnswers[
                                              "checklist[${checklist.id}]"] ==
                                          "no"
                                      ? Colors.red
                                      : Colors.grey,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'No',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                // Complaints Section
                if (checklistController.complaints.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  const Text(
                    'Complaints',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...checklistController.complaints.map((complaint) =>
                      SizedBox(
                        
                        width: double.infinity,
                        child: Card(
                          color: Colors.red,
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date: ${complaint.date}',
                                  style: const TextStyle(color: white),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Complaint: ${complaint.complaint}',
                                  style: const TextStyle(color: white),
                                ),
                                if (complaint.image != null) ...[
                                  const SizedBox(height: 8),
                                  Image.network(
                                    "https://esmagroup.online/surabhi/public/complaints/${complaint.image!}",
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Text('Image not available');
                                    },
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      )),
                ],

                // Image Picker Section
                const SizedBox(height: 24),
                const Text(
                  'Add Images',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ImagePickerWidget(controller: checklistController),

                // Status Dropdown Section
                const SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                  items: _statusOptions.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status.capitalize ?? status),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedStatus = newValue;
                      });
                    }
                  },
                ),

                // Submit Button
                const SizedBox(height: 24),
                PrimaryButtonWidget(
                  title: "Submit",
                  onPressed: () {
                    // Validate answers
                    if (checklistController.checklists.length !=
                        checklistController.checklistAnswers.length) {
                      Get.snackbar(
                        'Error',
                        'Please answer all checklist questions',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    // Update the image validation in your submit button
                    if (checklistController.images
                        .every((imageRx) => imageRx.value == null)) {
                      Get.snackbar(
                        'Error',
                        'Please take at least one image',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    checklistController.submitChecklist(
                      toiletId: widget.toiletId,
                      status: _selectedStatus,
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      }),
    );
  }
}
