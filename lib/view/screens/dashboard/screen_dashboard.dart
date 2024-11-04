import 'package:flutter/material.dart';
import 'package:surabhi/view/screens/main/widgets/custom_app_bar.dart';

class screenDashboard extends StatelessWidget {
  const screenDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: 'Dashboard'),
    );
  }
}