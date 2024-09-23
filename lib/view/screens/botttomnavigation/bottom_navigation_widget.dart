import 'package:flutter/material.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/controller/user/userController.dart';
import 'package:surabhi/view/screens/bookscreen/screen_maintain.dart';
import 'package:surabhi/view/screens/botttomnavigation/constants.dart';
import 'package:surabhi/view/screens/login/login_screen.dart';
import 'package:surabhi/view/screens/profile/profile_screen.dart';
import 'package:surabhi/view/widgets/qr_code_widget.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;
final UserController _userController = UserController();
  final List<Widget> _screens = [
   ScreenMaintain(),
    QRCodeScannerPage(),
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
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: white,
        
        toolbarHeight: 50, // Increased toolbar height
       
        actions: [
          Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.only(right: 16.0), // Adjusted padding for menu
              child: IconButton(
                iconSize: 40, // Increased icon size
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ),
        ],
      ),
      endDrawer: Drawer( width: MediaQuery.of(context).size.width * 0.6,
        surfaceTintColor: white,
        backgroundColor: backgroundColorWhite,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            children: <Widget>[
               DrawerHeader(
                decoration: const BoxDecoration(
                  color: backgroundColorWhite,
                ),
                child: SizedBox(
                  height: 40,
                  child: Image.asset(logo,),
 
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home,color: primaryButton,size: 26,),
                title: const Text('Home',style: TextStyles.drawerText,),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.search,color: primaryButton,size: 26,),
                title: const Text('Search',style: TextStyles.drawerText,),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications,color: primaryButton,size: 26,),
                title: const Text('Notifications',style: TextStyles.drawerText,),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout,color: primaryButton,size: 26,),
                title: const Text('Logout',style: TextStyles.drawerText,),
                onTap: () {
                  _userController.logout(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        unselectedItemColor: primaryButton,
        unselectedIconTheme: const IconThemeData(color: primaryButton),
        backgroundColor: backgroundColorWhite,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.blueAccent,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.handyman_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border_outlined),
            label: '',
          ),
        
          BottomNavigationBarItem(
            icon: Icon(Icons.dangerous),
            label: '',
          ),
        ],
      ),
    );
  }
}