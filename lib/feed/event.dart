import 'package:dindin_app/editevent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Event extends StatefulWidget {
  final int userRole;
  const Event({super.key, required this.userRole});

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> allEvents = [
    {
      'title': 'Pre-registration',
      'startDate': DateTime(2025, 2, 1),
      'endDate': DateTime(2025, 2, 1),
      'description': 'Description for Pre-registration event.',
    },
    {
      'title': 'Workshop Flutter',
      'startDate': DateTime(2025, 2, 5),
      'endDate': DateTime(2025, 2, 5),
      'description': 'Description for Workshop Flutter event.',
    },
    {
      'title': 'Tech Conference',
      'startDate': DateTime(2025, 2, 10),
      'endDate': DateTime(2025, 2, 10),
      'description': 'Description for Tech Conference event.',
    },
    {
      'title': 'Hackathon 2025',
      'startDate': DateTime(2025, 3, 15),
      'endDate': DateTime(2025, 3, 15),
      'description': 'Description for Hackathon 2025.',
    },
    {
      'title': 'AI Seminar',
      'startDate': DateTime(2025, 3, 20),
      'endDate': DateTime(2025, 3, 20),
      'description': 'Description for AI Seminar.',
    },
    {
      'title': 'Cybersecurity Talk',
      'startDate': DateTime(2025, 4, 5),
      'endDate': DateTime(2025, 4, 5),
      'description': 'Description for Cybersecurity Talk.',
    },
    {
      'title': 'Startup Meetup',
      'startDate': DateTime(2025, 5, 10),
      'endDate': DateTime(2025, 5, 10),
      'description': 'Description for Startup Meetup.',
    },
    {
      'title': 'Design Sprint',
      'startDate': DateTime(2025, 2, 6),
      'endDate': DateTime(2025, 3, 15),
      'description': 'Description for Design Sprint.',
    },
    {
      'title': 'Event July to August',
      'startDate': DateTime(2025, 7, 15),
      'endDate': DateTime(2025, 8, 15),
      'description': 'Event spanning from July to August',
    },
  ];

  List<Map<String, dynamic>> filteredEvents = [];
  DateTime? selectedMonthYear;

  @override
  void initState() {
    super.initState();

    filteredEvents = List.from(allEvents);

    _searchController.addListener(() {
      filterEvents();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void filterEvents() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      if (selectedMonthYear == null) {
        filteredEvents = allEvents
            .where((event) => event['title'].toLowerCase().contains(query))
            .toList();
      } else {
        filteredEvents = allEvents.where((event) {
          final titleMatch = event['title'].toLowerCase().contains(query);
          final bool monthMatch =
              isEventInSelectedMonth(event, selectedMonthYear!);
          return titleMatch && monthMatch;
        }).toList();
      }
    });
  }

  bool isEventInSelectedMonth(
      Map<String, dynamic> event, DateTime selectedMonthYear) {
    DateTime start = event['startDate'];
    DateTime end = event['endDate'];

    DateTime monthStart =
        DateTime(selectedMonthYear.year, selectedMonthYear.month, 1);
    DateTime monthEnd =
        DateTime(selectedMonthYear.year, selectedMonthYear.month + 1, 1)
            .subtract(const Duration(days: 1));

    return start.isBefore(monthEnd.add(const Duration(days: 1))) &&
        end.isAfter(monthStart.subtract(const Duration(days: 1)));
  }

  String _monthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
  }

  String formatMonthYear(DateTime? date) {
    return date == null
        ? "All Events"
        : "${_monthName(date.month)} ${date.year}";
  }

  void showMonthPicker() {
    int selectedMonth = selectedMonthYear?.month ?? DateTime.now().month;
    int selectedYear = selectedMonthYear?.year ?? DateTime.now().year;

    final years = List<int>.generate(10, (i) => 2023 + i);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                height: 350,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      '${_monthName(selectedMonth)} $selectedYear',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 12),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                  initialItem: selectedMonth - 1),
                              itemExtent: 32,
                              onSelectedItemChanged: (index) {
                                setStateDialog(() {
                                  selectedMonth = index + 1;
                                });
                              },
                              children: List<Widget>.generate(12, (index) {
                                return Center(
                                    child: Text(_monthName(index + 1)));
                              }),
                            ),
                          ),
                          Expanded(
                            child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                  initialItem: years.indexOf(selectedYear)),
                              itemExtent: 32,
                              onSelectedItemChanged: (index) {
                                setStateDialog(() {
                                  selectedYear = years[index];
                                });
                              },
                              children: years
                                  .map((y) => Center(child: Text(y.toString())))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selectedMonthYear = null;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text('All Events'),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedMonthYear =
                                      DateTime(selectedYear, selectedMonth);
                                  filterEvents();
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showEventDetailSheet(Map<String, dynamic> event) {
    String formatDate(DateTime d) {
      return "${d.day} ${_monthName(d.month)} ${d.year}";
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    event['title'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "${formatDate(event['startDate'])} - ${formatDate(event['endDate'])}",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    event['description'] ?? '',
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Location: Online / Auditorium A\nTime: 10:00 AM - 4:00 PM',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime d) {
      return "${d.day} ${_monthName(d.month)} ${d.year}";
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, size: 18),
                  SizedBox(width: 8),
                  Text(
                    formatMonthYear(selectedMonthYear),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: showMonthPicker,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: filteredEvents.isEmpty
                  ? Center(child: Text('No events found.'))
                  : ListView.builder(
                      itemCount: filteredEvents.length,
                      itemBuilder: (context, index) {
                        final event = filteredEvents[index];
                        return GestureDetector(
                          onTap: () {
                            showEventDetailSheet(event);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlue[100],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              event['title'] ?? '',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              "${formatDate(event['startDate'])} - ${formatDate(event['endDate'])}",
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),

                                        // icon noti or edit dlt
                                        widget.userRole == 3
                                            ? PopupMenuButton<String>(
                                                onSelected: (value) {
                                                  if (value == 'edit') {
                                                   Navigator.push(context, MaterialPageRoute(builder: (_) => Editevent()));
                                                  } else if (value ==
                                                      'delete') {
                                                    showDialogDelete(context);
                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  const PopupMenuItem(
                                                    value: 'edit',
                                                    child: Text('Edit'),
                                                  ),
                                                  const PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                ],
                                                icon: const Icon(
                                                    Icons.more_vert_outlined),
                                              )
                                            : const Icon(
                                                Icons.notifications_none),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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

Future<String?> showDialogDelete(BuildContext context) async {
  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
            child: Text(
              'Delete event?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          const Divider(
            height: 1.0,
            thickness: 0.5,
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context), // Cancel = null
                  style: TextButton.styleFrom(
                    minimumSize: const Size(0, 50),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
                child: VerticalDivider(
                  width: 1,
                  thickness: 0.5,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () =>
                      Navigator.pop(context, 'deleted'), // return deleted
                  style: TextButton.styleFrom(
                    minimumSize: const Size(0, 50),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
