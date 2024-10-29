
import 'package:flutter/material.dart';

class ToiletCardWidget extends StatelessWidget {
  final String toiletCode;
  final bool isChecked;

  const ToiletCardWidget({
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