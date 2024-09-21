import 'package:flutter/material.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/view/screens/main/screen_main.dart';
import 'package:surabhi/view/widgets/primary_button_widget.dart';


class SmoothContainerWithImage extends StatelessWidget {
  final double height;
  final Color color;
  final String imageUrl;

  const SmoothContainerWithImage({
    Key? key,
    this.height = 0.3, // Adjusted height to a smaller value
    this.color = Colors.blue,
    this.imageUrl = "https://shorturl.at/dtmRa",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Moved SingleChildScrollView here to cover entire page
      child: Column(
        children: [
          ClipPath(
            clipper: SmoothClipper(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * height, // Smaller height for the top container
              color: color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const LoginForm(),
          ),
        ],
      ),
    );
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

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: PrimaryButtonWidget(
            title: "login", 
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ScreenMain(),
                ),
              );
            }
          ),
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
    );
  }
}
