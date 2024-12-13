import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:surabhi/constants/colors.dart';
import 'package:surabhi/constants/constants.dart';
import 'package:surabhi/view/screens/dashboard%20copy/widgets/info_container_widget.dart';
import 'package:surabhi/view/screens/dashboard%20copy/widgets/tutor_tile_widget.dart';
import 'package:surabhi/view/screens/main/widgets/custom_app_bar.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final List<ToiletAnalyticsItem> analyticsList1 = [
    ToiletAnalyticsItem(name: 'Txxx4', details: '10'),
    ToiletAnalyticsItem(name: 'Txxxx5', details: '100'),
    ToiletAnalyticsItem(name: 'Txx6', details: '78'),
    ToiletAnalyticsItem(name: 'Txxx8', details: '66'),
  ];

  final List<ToiletAnalyticsItem> analyticsList2 = [
    ToiletAnalyticsItem(name: 'Txxx12', details: '150'),
    ToiletAnalyticsItem(name: 'Txxx12', details: '4'),
    ToiletAnalyticsItem(name: 'Txxx12', details: '2'),
    ToiletAnalyticsItem(name: 'Txxx12', details: '3 times'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColorlightgrey,
      appBar: CustomAppBar(title: 'Dashboard'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section with Gradient Background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    secondary.withOpacity(0.9),
                    secondaryButton.withOpacity(0.7),
                  ],
                ),
              ),
              child: Column(
                children: [
                  kHeight20,
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TutorTileWidget(
                      imageSize: 75,
                      imageUrl:
                          'https://tse4.mm.bing.net/th?id=OIP.l3pyHp3P_Ytr0yMHMsWZtwHaHa&pid=Api&P=0&h=180',
                      tutorName: 'Sandeep KA',
                      subjects: 'Supervisor',
                    ),
                  ),
                  kHeight20,
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Scroll View
                  kHeight15,
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      children: const [
                        InfoContainerWidget(
                          title: 'Pending',
                          value: '10',
                          color: secondary,
                        ),
                        SizedBox(width: 12),
                        InfoContainerWidget(
                          title: 'No. of toilets',
                          value: '100',
                          color: secondaryButton,
                        ),
                        SizedBox(width: 12),
                        InfoContainerWidget(
                          title: 'Staff attendance',
                          value: '78%',
                          color: secondary,
                        ),
                        SizedBox(width: 12),
                        InfoContainerWidget(
                          title: 'Additional Info',
                          value: '00',
                          color: secondaryButton,
                        ),
                      ],
                    ),
                  ),

                  // Performance Chart Section
                  kHeight25,
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Performance Overview',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        kHeight20,
                        ToiletManagementChart(),
                      ],
                    ),
                  ),

                  // Analytics Sections
                  kHeight25,
                  ToiletAnalyticsSection(
                    analyticsItems: analyticsList1,
                    leftHeading: 'Top Performing',
                    onViewMore: () {},
                    gradientColors: [secondary, secondaryButton],
                  ),
                  kHeight20,
                  ToiletAnalyticsSection(
                    analyticsItems: analyticsList2,
                    leftHeading: 'Worst Performing',
                    onViewMore: () {},
                    gradientColors: [Colors.red.shade300, Colors.red.shade200],
                  ),
                ],
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
  final String leftHeading;
  final VoidCallback onViewMore;
  final List<Color> gradientColors;

  const ToiletAnalyticsSection({
    super.key,
    required this.analyticsItems,
    required this.leftHeading,
    required this.onViewMore,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  leftHeading,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
                TextButton(
                  onPressed: onViewMore,
                  child: const Text(
                    'View More',
                    style: TextStyle(
                      fontSize: 14,
                      color: white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: analyticsItems.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(fontSize: 14, color: hintTextColor),
                      ),
                      Text(
                        item.details,
                        style: TextStyle(
                          fontSize: 14,
                          color: hintTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Replace the previous PerformanceChart with this new implementation
class ToiletManagementChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Toilet Status Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kHeight20,
              Row(
                children: [
                  // Pie Chart Section
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                          sections: [
                            PieChartSectionData(
                              value: 45,
                              title: '45%',
                              color: Colors.green,
                              radius: 50,
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              value: 30,
                              title: '30%',
                              color: Colors.orange,
                              radius: 50,
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              value: 15,
                              title: '15%',
                              color: Colors.red,
                              radius: 50,
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              value: 10,
                              title: '10%',
                              color: Colors.grey,
                              radius: 50,
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  kWidth20,
                  // Legend Section
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _legendItem('Operational', '450', Colors.green),
                        _legendItem('Needs Attention', '300', Colors.orange),
                        _legendItem('Out of Service', '150', Colors.red),
                        _legendItem('Under Maintenance', '100', Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
              kHeight20,
              // Quick Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _quickStat(
                    'Total Toilets',
                    '1,000',
                    Icons.wc,
                    secondary,
                  ),
                  _quickStat(
                    'Active Cleaners',
                    '85',
                    Icons.cleaning_services,
                    Colors.green,
                  ),
                  _quickStat(
                    'Pending Issues',
                    '45',
                    Icons.warning,
                    Colors.orange,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _legendItem(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickStat(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
