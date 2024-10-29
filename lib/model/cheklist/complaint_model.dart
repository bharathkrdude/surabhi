import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:surabhi/controller/checklist/checklist_controller.dart';
import 'package:surabhi/view/screens/update/update_status.dart';
import 'package:surabhi/view/widgets/primary_button_widget.dart';

class ChecklistScreen extends StatefulWidget {
  final int toiletId;

  const ChecklistScreen({Key? key, required this.toiletId}) : super(key: key);

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  String _selectedStatus = 'pending';
  final List<String> _statusOptions = ['pending', 'completed'];
  final ChecklistController checklistController = Get.put(ChecklistController());

  @override
  void initState() {
    super.initState();
    checklistController.fetchChecklistData(widget.toiletId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Checklist'),
      ),
      body: Obx(() {
        if (checklistController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
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
                                onPressed: () => checklistController.updateChecklistAnswer(
                                  index: index + 1,
                                  value: "yes",
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: checklistController.checklistAnswers["checklist[${index + 1}]"] == "yes"
                                      ? Colors.green
                                      : Colors.grey,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
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
                                onPressed: () => checklistController.updateChecklistAnswer(
                                  index: index + 1,
                                  value: "no",
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: checklistController.checklistAnswers["checklist[${index + 1}]"] == "no"
                                      ? Colors.red
                                      : Colors.grey,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
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
                }).toList(),

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
                  ...checklistController.complaints.map((complaint) => Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${complaint.date}'),
                          const SizedBox(height: 8),
                          Text('Complaint: ${complaint.complaint}'),
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
                  )).toList(),
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
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    // Validate image
                    if (checklistController.image.value == null) {
                      Get.snackbar(
                        'Error',
                        'Please select an image',
                        snackPosition: SnackPosition.BOTTOM,
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
