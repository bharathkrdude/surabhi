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
        title: Text('Cleaner Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : AssetImage('assets/default_profile.png') as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: getImage,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Dennies',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'ID: CLN12345',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 24),
            ListTile(
              leading: Icon(Icons.work),
              title: Text('Current Assignment'),
              subtitle: Text('Floor 3, Building B'),
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('Shift'),
              subtitle: Text('8:00 AM - 4:00 PM'),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Performance Rating'),
              subtitle: Text('4.8/5.0'),
            ),
            ListTile(
              leading: Icon(Icons.cleaning_services),
              title: Text('Areas of Expertise'),
              subtitle: Text('Toilet Cleaning, Floor Mopping, Sanitization'),
            ),
            ListTile(
              leading: Icon(Icons.event_note),
              title: Text('Tasks Completed Today'),
              subtitle: Text('7/10'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Edit Profile'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to edit profile page
              },
            ),
            ListTile(
              leading: Icon(Icons.report_problem),
              title: Text('Report Issue'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to issue reporting page
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('End Shift'),
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
