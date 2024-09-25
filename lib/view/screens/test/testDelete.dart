import 'package:flutter/material.dart';
import 'package:surabhi/view/screens/botttomnavigation/constants.dart';

class TestDelete extends StatelessWidget {
  const TestDelete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            kHeight20,
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.1,
              color: Colors.amber,
              child: const Card(
                  
              ),
            )
          ],
        ),
      ),
    );
  }
}