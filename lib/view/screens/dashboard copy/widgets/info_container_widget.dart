import 'package:flutter/material.dart';
import 'package:surabhi/constants/colors.dart';

class InfoContainerWidget extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const InfoContainerWidget({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.29, // Increased width
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12, // Smaller font size
                fontWeight: FontWeight.normal, // Less bold
              ),
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18, // Larger font size
                fontWeight: FontWeight.bold, // Bold for emphasis
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ToiletAnalyticsSection extends StatelessWidget {
  final List<ToiletAnalyticsItem> analyticsItems;

  const ToiletAnalyticsSection({
    Key? key,
    required this.analyticsItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Toilet Analytics',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Column(
            children: analyticsItems.map((item) {
              return AnalyticsRow(item: item);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class AnalyticsRow extends StatelessWidget {
  final ToiletAnalyticsItem item;

  const AnalyticsRow({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.analytics_outlined,
            size: 14,
            color: item.iconColor ?? Colors.black87,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              item.name,
              style: TextStyle(
                fontSize: 14,
                color: hintTextColor,
              ),
            ),
          ),
          Text(
            item.details,
            style: TextStyle(
              fontSize: 14,
              color: hintTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

class ToiletAnalyticsItem {
  final String name;
  final String details;
  final Color? iconColor;

  ToiletAnalyticsItem({
    required this.name,
    required this.details,
    this.iconColor,
  });
}

// Example usage with festival-specific analytics data
final List<ToiletAnalyticsItem> analyticsList = [
  ToiletAnalyticsItem(
    name: 'Maintenance Checks',
    details: 'Every 2 hours',
  ),
  ToiletAnalyticsItem(
    name: 'Average Wait Time',
    details: '5 minutes',
  ),
  ToiletAnalyticsItem(
    name: 'Cleaning Intervals',
    details: '3 times daily',
  ),
  ToiletAnalyticsItem(
    name: 'Water Refill Frequency',
    details: 'Twice daily',
  ),
  ToiletAnalyticsItem(
    name: 'Usage Count',
    details: '150 uses/day',
  ),
  ToiletAnalyticsItem(
    name: 'Hand Sanitizer Levels',
    details: 'Refilled every 4 hours',
  ),
];
