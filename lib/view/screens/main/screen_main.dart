import 'package:flutter/material.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/view/screens/botttomnavigation/bottom_navigation_widget.dart';

class ScreenMain extends StatelessWidget {
  const ScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    return  const SafeArea(
      child: Scaffold(
        
       
        bottomNavigationBar: BottomNavigationWidget(),
      ),
    );
  }
}
