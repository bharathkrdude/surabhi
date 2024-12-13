
import 'package:flutter/material.dart';
import 'package:surabhi/constants/colors.dart';

class ToiletCardWidget extends StatelessWidget {
  final String toiletCode;
  final bool isChecked;

  const ToiletCardWidget({
    super.key,
    required this.toiletCode,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: white,
      color: white,
      shadowColor: secondary,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
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
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
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
      ),
    );
  }
}