 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/controller/auth/auth_controller.dart';
import 'package:surabhi/view/widgets/primary_button_widget.dart';

const baseUrl = 'https://esmagroup.online/surabhi/api/v1/';
const postLoginUrl = '${baseUrl}login';

class CurvedLoginScreen extends StatelessWidget {
  const CurvedLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ClipPath(
            clipper: SmoothClipper(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              color: white,
              child: Center(
                child: Image.asset('assets/images/surbhi_logo-removebg-preview.png',
                    height: 200, width: 100),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoginForm(),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final AuthController authController = Get.find();

   LoginForm({super.key}); // GetX dependency injection

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: authController.emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email, color: primaryButton),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: authController.passwordController,
            obscureText: authController.obscurePassword.value,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock, color: primaryButton),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              suffixIcon: IconButton(
                icon: Icon(authController.obscurePassword.value ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  authController.togglePasswordVisibility();
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (authController.errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                authController.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          authController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PrimaryButtonWidget(
                    title: "Login",
                    onPressed: () {
                      authController.login(
                        authController.emailController.text,
                        authController.passwordController.text,
                      );
                    },
                  ),
                ),
          const SizedBox(height: 20),
        ],
      );
    });
  }
}

class SmoothClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.9);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.95,
      size.width * 0.5,
      size.height * 0.9,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.85,
      size.width,
      size.height * 0.9,
    );

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
} 

