import 'package:flutter/material.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/view/screens/login/widgets/textbutton_widget.dart';
import 'package:surabhi/view/screens/maintainanceDetail/widget/bookng_card_widget.dart';

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
                  return GestureDetector(
                    onTap: () {
                      // Show a popup dialog when an item is clicked
                      _showPopup(context, index);
                    },
                    child: CustomContainerWithMark(isChecked: index % 2 == 0), // Custom widget for each grid item
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPopup(BuildContext context, int index) {
    showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero, // Remove default padding
                  content: BookingCard(index: 1), // Pass index or any required data
                );
              },
            );
  }
}

class CustomContainerWithMark extends StatelessWidget {
  final bool isChecked; // True for check mark, false for cancel mark

  const CustomContainerWithMark({Key? key, required this.isChecked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 3,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: Stack(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
  padding: EdgeInsets.all(4.0),
  decoration: BoxDecoration(
    color: primaryButton1, // Change this to your desired color
    borderRadius: BorderRadius.circular(8.0),
  ),
  child: Text(
    "0111",
    style: TextStyle(
      color: Colors.white, // Text color
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
  ),
)
,
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                isChecked ? Icons.check_circle : Icons.cancel,
                color: isChecked ? Colors.green : Colors.red,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);


  }
}
