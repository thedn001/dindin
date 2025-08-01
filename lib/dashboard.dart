import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

enum DashboardTab { today, weekly, month }

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            color: Colors.grey[200],
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: const Color(0xFF2E3B4E),
                borderRadius: BorderRadius.circular(10),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(text: 'Today'),
                Tab(text: 'Weekly'),
                Tab(text: 'Month'),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TabBarView(
          controller: _tabController,
          children: [
            DashboardContent(tab: DashboardTab.today),
            DashboardContent(tab: DashboardTab.weekly),
            DashboardContent(tab: DashboardTab.month),
          ],
        ),
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  final DashboardTab tab;

  const DashboardContent({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    String dateRange;
    List<int> barData;
    String postCount;
    List<String> labels;

    switch (tab) {
      case DashboardTab.today:
        
        labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
        barData = [150, 200, 180, 220, 170, 210, 190];
        dateRange = 'June 30, 2025';
        postCount = '350';
        break;
      case DashboardTab.weekly:
        labels = ['M', 'T', 'W', 'TH', 'F', 'S', 'S'];
        barData = [80, 450, 50, 500, 400, 400, 400];
        dateRange = 'June 23 - June 29, 2025';
        postCount = '2280';
        break;
      case DashboardTab.month:
        labels = ['W1', 'W2', 'W3', 'W4'];
        barData = [3000, 2800, 3200, 3100];
        dateRange = 'June 1 - June 30, 2025';
        postCount = '12000';
        break;
    }

    return ListView(
      children: [
        const SizedBox(height: 10),
        Center(child: Text(dateRange)),
        const SizedBox(height: 16),
        _buildBarChart(barData, labels, tab),
        const SizedBox(height: 8),
        Center(child: Text('Number of Post : $postCount')),
        const Divider(height: 32),
        _buildPieChart(),
        const SizedBox(height: 8),
        _buildLegend(),
        const Divider(height: 32),
        const Text('Number of Report : 270', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _buildReportRow('Scam', 40, 20),
        _buildReportRow('Bullying', 80, 15),
        _buildReportRow('Suicide', 30, 10),
        _buildReportRow('Others', 120, 25),
      ],
    );
  }

  Widget _buildBarChart(List<int> barData, List<String> labels, DashboardTab tab) {
    if (tab == DashboardTab.today) {
      final todayIndex = DateTime.now().weekday - 1;
      final value = barData[todayIndex];

      return SizedBox(
        height: 200,
        child: BarChart(
          BarChartData(
            barGroups: [
              BarChartGroupData(x: 0, barRods: [
                BarChartRodData(
                  toY: value.toDouble(),
                  color: const Color(0xFF2E3B4E),
                  width: 50,
                  borderRadius: BorderRadius.circular(6),
                )
              ]),
            ],
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(labels[todayIndex]),
                  ),
                ),
              ),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            barTouchData: BarTouchData(enabled: false),
          ),
        ),
      );
    } else {
      int highlightIndex = 0;
      for (int i = 1; i < barData.length; i++) {
        if (barData[i] > barData[highlightIndex]) {
          highlightIndex = i;
        }
      }

      return SizedBox(
        height: 200,
        child: BarChart(
          BarChartData(
            barGroups: List.generate(barData.length, (i) {
              final isHighlight = (i == highlightIndex);

              return BarChartGroupData(x: i, barRods: [
                BarChartRodData(
                  toY: barData[i].toDouble(),
                  color: isHighlight ? const Color(0xFF2E3B4E) : Colors.grey,
                  width: 16,
                  borderRadius: BorderRadius.circular(6),
                )
              ]);
            }),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(labels[value.toInt()]),
                  ),
                ),
              ),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            barTouchData: BarTouchData(enabled: false),
          ),
        ),
      );
    }
  }

  Widget _buildPieChart() {
    return SizedBox(
      height: 160,
      child: PieChart(
        PieChartData(
          sections: [
           PieChartSectionData(value: 1000, color: Color(0xFF4F6272), radius: 30), 
PieChartSectionData(value: 1200, color: Color(0xFF6C7A89), radius: 30), 
PieChartSectionData(value: 950, color: Color(0xFF90A4AE), radius: 30),  
PieChartSectionData(value: 5300, color: Color(0xFFB0BEC5), radius: 30), 

          ],
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Column(
      children: const [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _LegendItem(color: Color(0xFF4F6272), label: 'Likes 1k'),
            _LegendItem(color: Color(0xFF6C7A89), label: 'Reports 1.2K'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _LegendItem(color: Color(0xFF90A4AE), label: 'Comments 950'),
            _LegendItem(color: Color(0xFFB0BEC5), label: 'Bookmarks 5.3K'),
          ],
        ),
      ],
    );
  }

  Widget _buildReportRow(String title, double primaryValue, double secondaryValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: LinearProgressIndicator(
                value: primaryValue / 150,
                color: Colors.grey[700],
                backgroundColor: Colors.grey[300],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: LinearProgressIndicator(
                value: secondaryValue / 50,
                color: Color.fromARGB(255, 1, 39, 71),
                backgroundColor: Colors.grey[300],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 5, backgroundColor: color),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}
