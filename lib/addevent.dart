import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Addevent extends StatefulWidget {
  const Addevent({super.key});

  @override
  State<Addevent> createState() => _AddeventState();
}

class _AddeventState extends State<Addevent> {
  final TextEditingController _titleController = TextEditingController();
    final TextEditingController _detailController = TextEditingController();

    DateTime? startDate;
    DateTime? endDate;

    Future<void> pickDateRange(BuildContext context) async {
      final DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2023),
        lastDate: DateTime(2030),
        initialDateRange: startDate != null && endDate != null
            ? DateTimeRange(start: startDate!, end: endDate!)
            : null,
      );

      if (picked != null) {
        setState(() {
          startDate = picked.start;
          endDate = picked.end;
        });
      }
    }

     String formatDateRange(DateTime? start, DateTime? end) {
      if (start == null || end == null) return "Select date range";
      final formatter = DateFormat('dd/MM/yyyy');
      return "${formatter.format(start)} - ${formatter.format(end)}";
    }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Image.asset('assets/images/dindin.png', width: 40),
                ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.isEmpty ||
                        _detailController.text.isEmpty ||
                        startDate == null ||
                        endDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please fill all required fields')),
                      );
                      return;
                    }

                    final newEvent = {
                      'title': _titleController.text.trim(),
                      'description': _detailController.text.trim(),
                      'startDate': startDate!,
                      'endDate': endDate!,
                    };

                    Navigator.pop(context, newEvent);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFFF2B949),
                    minimumSize: const Size(80, 30),
                  ),
                  child: const Text('Post'),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Divider(
                height: 1.0,
                thickness: 1.0,
                color: Colors.grey.shade300,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title input
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            hintText: 'title',
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLength: 100,
                          maxLines: 1,
                          buildCounter: (
                            BuildContext context, {
                            required int currentLength,
                            required bool isFocused,
                            required int? maxLength,
                          }) {
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Builder(
                        builder: (context) {
                          final currentLength = _titleController.text.length;
                          return Text(
                            "$currentLength / 100",
                            style:
                                const TextStyle(fontSize: 14, color: Colors.grey),
                          );
                        },
                      ),
                    ],
                  ),

                  Divider(height: 1, color: Colors.grey.shade300),

                  // Detail input
                  Container(
                    height: 300,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: _detailController,
                      decoration: const InputDecoration(
                        hintText: 'detail',
                        border: InputBorder.none,
                      ),
                      maxLength: 500,
                      maxLines: null,
                      expands: true,
                      buildCounter: (
                        BuildContext context, {
                        required int currentLength,
                        required bool isFocused,
                        required int? maxLength,
                      }) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.image_outlined),
                            Text("$currentLength / $maxLength"),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(height: 1, color: Colors.grey.shade300),
                  const SizedBox(height: 20),

                  // Date range picker
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => pickDateRange(context),
                        icon: const Icon(Icons.calendar_today_outlined),
                      ),
                      Text(formatDateRange(startDate, endDate)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
