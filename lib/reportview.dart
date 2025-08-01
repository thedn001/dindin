import 'package:flutter/material.dart';

class Reportview extends StatefulWidget {
  const Reportview({super.key});

  @override
  State<Reportview> createState() => _ReportviewState();
}

class _ReportviewState extends State<Reportview> {
  List<Map<String, dynamic>> reports = [
    {'userId': '6xxxxxx123', 'name': 'Natty', 'type': 'Bullying'},
    {'userId': '6xxxxxx456', 'name': 'Gunny', 'type': 'Spam'},
    {'userId': '6xxxxxx789', 'name': 'Phuny', 'type': 'Gambling'},
    {'userId': '6xxxxxx456', 'name': 'Bamny', 'type': 'Bullying'},
  ];

  String selectedCategory = 'All';
  List<String> categories = ['All', 'Bullying', 'Spam', 'Gambling'];

  Set<String> selectedUserIds = {};

  @override
  Widget build(BuildContext context) {
     final filteredReports = selectedCategory == 'All'
        ? reports
        : reports.where((r) => r['type'] == selectedCategory).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back),
                  const Spacer(),
                  const Text(
                    'Report',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  for (final category in categories)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: selectedCategory == category
                                ? Colors.amber[600]
                                : Colors.transparent,
                            border: Border.all(
                              color: selectedCategory == category
                                  ? Colors.amber
                                  : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: selectedCategory == category
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  const Spacer(),
                  const Icon(Icons.search),
                ],
              ),
            ),

            const SizedBox(height: 10),

 
            Expanded(
              child: ListView.builder(
                itemCount: filteredReports.length,
                itemBuilder: (context, index) {
                  final report = filteredReports[index];
                  final userId = report['userId'];

                  final isSelected = selectedUserIds.contains(userId);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedUserIds.add(userId); 
                      });
                    },
                    child: Container(
                      color: isSelected ? Colors.white : Colors.blue[50],
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      margin: const EdgeInsets.only(bottom: 1),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black45,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(userId,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 2),
                                Text(report['type'],
                                    style: const TextStyle(color: Colors.grey)),
                                const SizedBox(height: 2),
                                Text(
                                  'Report post ${report['name']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
