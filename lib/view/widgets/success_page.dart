import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:surabhi/view/screens/botttomnavigation/bottom_navigation_widget.dart';
import 'package:surabhi/view/widgets/primary_button_widget.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  SuccessPageState createState() => SuccessPageState();
}

class SuccessPageState extends State<SuccessPage> {
  bool _isAnimationComplete = false;

  @override
  void initState() {
    
    super.initState();
    _playAnimation();
  }

  void _playAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() {
      _isAnimationComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // New Success Animation
                Lottie.network(
                  // Option 1: Confetti celebration animation
                  'https://assets10.lottiefiles.com/packages/lf20_s2lryxtd.json',
                  // // Option 2: Checkmark with particles
                  // 'https://assets4.lottiefiles.com/packages/lf20_jbrw3hcz.json',
                  // Option 3: Success check with circle
                  // 'https://assets9.lottiefiles.com/packages/lf20_rc5d0f61.json',
                  height: 250,
                  repeat: false,
                  onLoaded: (composition) {
                    // Optional: Handle loading completion
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.shade50,
                      ),
                      child: Icon(
                        Icons.check_circle,
                        size: 80,
                        color: Colors.green[700],
                      ),
                    );
                  },
                ),
                
                AnimatedOpacity(
                  opacity: _isAnimationComplete ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    children: [
                      Text(
                        'Success!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your submission has been received',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 100),
                
                AnimatedOpacity(
                  opacity: _isAnimationComplete ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: PrimaryButtonWidget(
                      title: "Back to Home",
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  const BottomNavigationWidget(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
