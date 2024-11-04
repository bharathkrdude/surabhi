import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/controller/dropdown_sample.dart';
import 'package:surabhi/view/screens/dashboard/screen_dashboard.dart';
import 'package:surabhi/view/screens/profile/profile_screen.dart';
import 'package:surabhi/view/screens/test/testDelete.dart';
import 'package:surabhi/view/widgets/qr_code_widget.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    //  ScreenMaintain(),
    screenDashboard(),
     ScreenMaintainTest(),
    const QRCodeScannerPage(),
   
    // const Center(child: Text("Alerts Page")),
    ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorgrey,
      
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Get.theme.primaryColor,
        unselectedItemColor: Colors.grey[600],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        items: [
          _buildBottomNavItem(Icons.dashboard, 'Dashboard'),
          // _buildBottomNavItem(Icons.bookmark_border_outlined, 'Bookmarks'),
          _buildBottomNavItem(Icons.warning_amber_sharp, 'Toilets'),
          _buildBottomNavItem(Icons.qr_code, 'Scan'),
          _buildBottomNavItem(Icons.person_2_outlined, 'Profile'),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: _buildIcon(icon),
      label: label,
      activeIcon: _buildIcon(icon, active: true),
    );
  }

  Widget _buildIcon(IconData icon, {bool active = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 24,
          color: active ? Get.theme.primaryColor : Colors.grey[600],
        ),
        if (active)
          Container(
            margin: const EdgeInsets.only(top: 4.0),
            height: 2,
            width: 24,
            color: Get.theme.primaryColor,
          ),
      ],
    );
  }
}
