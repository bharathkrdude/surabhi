import 'package:flutter/material.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/view/screens/dashboard%20copy/dashboard_screen.dart';
import 'package:surabhi/view/screens/profile/profile_screen.dart';
import 'package:surabhi/view/screens/toilets/screen_toilet.dart';
import 'package:surabhi/view/widgets/qr_code_widget.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  BottomNavigationWidgetState createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    //  ScreenDashboard(),
     DashboardScreen(),
     ScreenToilet(),
    const QRCodeScannerPage(),
    const ProfilePage(),
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
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: secondary,
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      items: [
        CustomBottomNavigationBarItem(
          icon: Icons.dashboard,
          label: 'Dashboard',
          isActive: currentIndex == 0,
        ),
        CustomBottomNavigationBarItem(
          icon: Icons.room,
          label: 'Toilets',
          isActive: currentIndex == 1,
        ),
        CustomBottomNavigationBarItem(
          icon: Icons.qr_code,
          label: 'Scan',
          isActive: currentIndex == 2,
        ),
        CustomBottomNavigationBarItem(
          icon: Icons.person_2_outlined,
          label: 'Profile',
          isActive: currentIndex == 3,
        ),
      ].map((item) => item.toBottomNavigationBarItem()).toList(),
    );
  }
}

class CustomBottomNavigationBarItem {
  final IconData icon;
  final String label;
  final bool isActive;

  CustomBottomNavigationBarItem({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  BottomNavigationBarItem toBottomNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: CustomIconWidget(
        icon: icon,
        isActive: isActive,
      ),
      label: label,
    );
  }
}

class CustomIconWidget extends StatelessWidget {
  final IconData icon;
  final bool isActive;

  const CustomIconWidget({
    required this.icon,
    this.isActive = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 24,
          color: isActive ? secondary : Colors.grey[600],
        ),
        if (isActive)
          Container(
            margin: const EdgeInsets.only(top: 4.0),
            height: 2,
            width: 24,
            color: secondary,
          ),
      ],
    );
  }
}
