import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/controller/toilet/toilet_cotroller.dart';
import 'package:surabhi/view/screens/login/widgets/textbutton_widget.dart';
import 'package:surabhi/view/screens/maintainanceDetail/widget/bookng_card_widget.dart';

class ScreenMaintain extends StatelessWidget {
  final ToiletController toiletController = Get.put(ToiletController());

  ScreenMaintain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorgrey,
      body: SafeArea(
        child: Column(
          children: [
             Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButtonWidget(),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (toiletController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    padding: const EdgeInsets.all(16),
                    itemCount: toiletController.toilets.length,
                    itemBuilder: (context, index) {
                      var toilet = toiletController.toilets[index];
                      return GestureDetector(
                        onTap: () => _showPopup(context, index),
                        child: CustomContainerWithMark(
                          toiletCode: toilet.toiletCode,
                          isChecked: toilet.toiletStatus == 'completed',
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showPopup(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: BookingCard(toilet: toiletController.toilets[index]),
        );
      },
    );
  }
}

class CustomContainerWithMark extends StatelessWidget {
  final String toiletCode;
  final bool isChecked;

  const CustomContainerWithMark({
    Key? key,
    required this.toiletCode,
    required this.isChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    toiletCode,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                  Expanded(
                    child: Image.asset(
                      "assets/images/toilet.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: isChecked ? Colors.green : Colors.red,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            child: Text(
              isChecked ? 'Completed' : 'Pending',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}