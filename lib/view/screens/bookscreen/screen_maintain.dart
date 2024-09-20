import 'package:flutter/material.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/view/screens/login/widgets/textbutton_widget.dart';

class ScreenMaintain extends StatelessWidget {
  const ScreenMaintain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorgrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.7),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextButtonWidget(),
                  ),
                ],
              ),
              // GridView for 4 items per row
              GridView.count(
                crossAxisCount: 4, // 4 items per row
                shrinkWrap: true, // Makes the GridView take only necessary space
                physics: const NeverScrollableScrollPhysics(), // Prevent GridView scrolling inside SingleChildScrollView
                crossAxisSpacing: 10, // Space between columns
                mainAxisSpacing: 10, // Space between rows
                padding: const EdgeInsets.all(10), // Padding around the GridView
                children: List.generate(8, (index) {
                  // Example with 8 items
                  return CustomContainerWithMark(isChecked: index % 2 == 0); // Custom widget for each grid item
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomContainerWithMark extends StatelessWidget {
  final bool isChecked; // True for check mark, false for cancel mark

  const CustomContainerWithMark({Key? key, required this.isChecked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.28,
      color: Colors.white,
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              "01", // You can replace this with dynamic content
              style: TextStyle(
                color: Colors.teal,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
       
          // Positioned Icon in the bottom-right corner
          Align(
            alignment: Alignment.bottomRight, // Aligns the icon to the bottom-right corner
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Add some padding for spacing
              child: Icon(
                isChecked ? Icons.check_circle : Icons.cancel, // Check mark or cancel mark
                color: isChecked ? Colors.green : Colors.red, // Green for check, red for cancel
                size: 28, // Size of the icon
              ),
            ),
          ),
        ],
      ),
    );
  }
}
