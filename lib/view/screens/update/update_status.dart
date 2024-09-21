import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surabhi/view/widgets/primary_button_widget.dart';

class UpdateStatusPage extends StatefulWidget {
  const UpdateStatusPage({Key? key}) : super(key: key);

  @override
  _UpdateStatusPageState createState() => _UpdateStatusPageState();
}

class _UpdateStatusPageState extends State<UpdateStatusPage> {
  String _selectedStatus = 'Pending';
  final List<String> _statusOptions = ['Pending', 'In Progress', 'Completed'];

  void _submit() {
    // Implement your submit logic here
    print('Submitting Status: $_selectedStatus');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImagePickerWidget(),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: _statusOptions.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStatus = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),
           PrimaryButtonWidget(title: "Submit", onPressed: _submit)
          ],
        ),
      ),
    );
  }
}



class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

Future<void> _pickImage(ImageSource source) async {
  try {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  } catch (e) {
    print('Error picking image: $e');
    // Show an error message to the user
  }
}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_image != null)
          Image.file(
            File(_image!.path),
            height: 200,
          )
        else
          const Text('No image selected'),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _pickImage(ImageSource.camera),
          child: const Text('Take Picture'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => _pickImage(ImageSource.gallery),
          child: const Text('Pick from Gallery'),
        ),
      ],
    );
  }
}
