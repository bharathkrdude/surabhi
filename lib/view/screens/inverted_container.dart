import 'package:flutter/material.dart';
import 'package:surabhi/view/screens/login/login_screen.dart';
import 'package:surabhi/view/screens/login/widgets/clipped_container.dart';

class SmoothContainerWithImage extends StatelessWidget {
  final double height;
  final Color color;
  final String imageUrl;

  const SmoothContainerWithImage({
    Key? key,
    this.height = 0.5,
    this.color = Colors.grey,
    this.imageUrl = "https://shorturl.at/dtmRa",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: SmoothClipper(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * height,
              color: color,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: Icon(Icons.error, color: Colors.white));
                },
              ),
            ),
          ),
          // Text("Welcome Back"),
          const Expanded(child: Padding(
            padding: EdgeInsets.all(8.0),
            child: LoginForm(),
          )),
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
