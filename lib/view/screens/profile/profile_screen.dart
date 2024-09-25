import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cleaner Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : const AssetImage('assets/default_profile.png') as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: getImage,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Dennies',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'ID: CLN12345',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const ListTile(
              leading: Icon(Icons.work),
              title: Text('Current Assignment'),
              subtitle: Text('Floor 3, Building B'),
            ),
            const ListTile(
              leading: Icon(Icons.schedule),
              title: Text('Shift'),
              subtitle: Text('8:00 AM - 4:00 PM'),
            ),
            const ListTile(
              leading: Icon(Icons.star),
              title: Text('Performance Rating'),
              subtitle: Text('4.8/5.0'),
            ),
            const ListTile(
              leading: Icon(Icons.cleaning_services),
              title: Text('Areas of Expertise'),
              subtitle: Text('Toilet Cleaning, Floor Mopping, Sanitization'),
            ),
            const ListTile(
              leading: Icon(Icons.event_note),
              title: Text('Tasks Completed Today'),
              subtitle: Text('7/10'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Edit Profile'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to edit profile page
              },
            ),
            ListTile(
              leading: const Icon(Icons.report_problem),
              title: const Text('Report Issue'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to issue reporting page
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('End Shift'),
              onTap: () {
                // Implement end shift functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
