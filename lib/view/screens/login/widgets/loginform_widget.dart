import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/controller/auth/authController.dart';
import 'package:surabhi/view/widgets/primary_button_widget.dart';

class LoginForm extends StatelessWidget {
  
   LoginForm({
    super.key,
  });
final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Full Name',
              prefixIcon: Icon(Icons.person, color: primaryButton),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock, color: primaryButton),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: false,
                  onChanged: (value) {},
                  shape: CircleBorder(),
                ),
              ),
              Text('Remember Me', style: TextStyle(color: Colors.grey)),
              Spacer(),
              Text('Forgot Password?', style: TextStyle(color: Colors.blue)),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryButtonWidget(title: "login", onPressed: () {}),
          ),
          SizedBox(height: 20),
          Center(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(text: "Don't have an account? "),
                  TextSpan(text: 'Sign up', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
