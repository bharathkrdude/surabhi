

import 'package:flutter/material.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/constants/constants.dart';
import 'package:surabhi/view/screens/main/widgets/custom_app_bar.dart';
import 'package:surabhi/view/widgets/custom_textfield.dart';
import 'package:surabhi/view/widgets/primary_button_widget.dart';

class ChangePassWordScreen extends StatelessWidget {
  ChangePassWordScreen({super.key});
 final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Change PassWord'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            kHeight40,
            CustomTextField(
           
              decoration: InputDecoration(
                labelText: 'Old Password',
                prefixIcon: const Icon(Icons.email, color: primaryButton),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ), controller:passwordController , labelText: 'Old password', prefixIcon: Icons.lock,
            ),
            kHeight20,
             CustomTextField(
           
              decoration: InputDecoration(
              
                prefixIcon: const Icon(Icons.email, color: primaryButton),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ), controller:passwordController , labelText: 'New Password', prefixIcon: Icons.lock_reset,
            ),
             kHeight20,
             CustomTextField(
           
              decoration: InputDecoration(
                
                prefixIcon: const Icon(Icons.email, color: primaryButton),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ), controller:passwordController , labelText: 'Re Enter Password', prefixIcon: Icons.lock_person_sharp,
            ),
            kHeight20,
            PrimaryButtonWidget(title: "submit", onPressed: (){})
          ],
        ),
      ),
    );
  }
}