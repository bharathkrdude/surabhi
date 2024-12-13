import 'package:flutter/material.dart';
import 'package:surabhi/view/screens/main/widgets/custom_app_bar.dart';
import 'package:fl_chart/fl_chart.dart';

class ScreenDashboard extends StatelessWidget {
  const ScreenDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Dashboard'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Row
              const StatsRow(),
              const SizedBox(height: 30),
              
              // Charts Section
              const Text(
                'Monthly Progress',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: ProgressChart(),
              ),
              const SizedBox(height: 30),

              // Distribution Chart
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 200,
                      child: ToiletDistributionPieChart(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ChartLegendItem(
                          color: Colors.green,
                          label: 'Completed',
                          value: '45%',
                        ),
                        SizedBox(height: 8),
                        ChartLegendItem(
                          color: Colors.orange,
                          label: 'In Progress',
                          value: '35%',
                        ),
                        SizedBox(height: 8),
                        ChartLegendItem(
                          color: Colors.red,
                          label: 'Pending',
                          value: '20%',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Worst and Best Toilets Section
              const Text(
                'Status Overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(
                    child: ToiletStatusCard(
                      title: 'Need Attention',
                      toiletNames: ['T1234', 'T5678', 'T9012'],
                      color: Colors.red,
                      icon: Icons.warning_rounded,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ToiletStatusCard(
                      title: 'Recently Completed',
                      toiletNames: ['T2468', 'T1357', 'T8024'],
                      color: Colors.green,
                      icon: Icons.check_circle_rounded,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: StatsCard(
            title: 'Pending',
            value: '10',
            color: Colors.orange,
            icon: Icons.pending_actions,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: StatsCard(
            title: 'Completed',
            value: '20',
            color: Colors.green,
            icon: Icons.check_circle,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: StatsCard(
            title: 'Sections',
            value: '15',
            color: Colors.blue,
            icon: Icons.grid_view,
          ),
        ),
      ],
    );
  }
}

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: color),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ToiletStatusCard extends StatelessWidget {
  final String title;
  final List<String> toiletNames;
  final Color color;
  final IconData icon;

  const ToiletStatusCard({
    super.key,
    required this.title,
    required this.toiletNames,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...toiletNames.map((name) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  name,
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class ProgressChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 3),
              FlSpot(2.6, 2),
              FlSpot(4.9, 5),
              FlSpot(6.8, 3.1),
              FlSpot(8, 4),
              FlSpot(9.5, 3),
              FlSpot(11, 4),
            ],
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}

class ToiletDistributionPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            color: Colors.green,
            value: 45,
            title: '',
            radius: 50,
          ),
          PieChartSectionData(
            color: Colors.orange,
            value: 35,
            title: '',
            radius: 50,
          ),
          PieChartSectionData(
            color: Colors.red,
            value: 20,
            title: '',
            radius: 50,
          ),
        ],
      ),
    );
  }
}

class ChartLegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;

  const ChartLegendItem({
    super.key,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
