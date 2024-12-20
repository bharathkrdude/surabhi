import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/controller/auth/auth_controller.dart';
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
              prefixIcon: const Icon(Icons.person, color: primaryButton),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock, color: primaryButton),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: false,
                  onChanged: (value) {},
                  shape: const CircleBorder(),
                ),
              ),
              const Text('Remember Me', style: TextStyle(color: Colors.grey)),
              const Spacer(),
              const Text('Forgot Password?', style: TextStyle(color: Colors.blue)),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryButtonWidget(title: "login", onPressed: () {}),
          ),
          const SizedBox(height: 20),
          Center(
            child: RichText(
              text: const TextSpan(
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
