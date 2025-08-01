import 'package:flutter/material.dart';

class Noti extends StatefulWidget {
  const Noti({super.key});

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Map<String, dynamic>> postNotifications = [
    {
      'icon': 'bell',
      'title': 'Post Content',
      'subtitle': 'Your post has been deleted by system',
      'time': '1 h',
      'isRead': false,
    },
    {
      'icon': 'comment',
      'title': 'Post Content',
      'subtitle': '2 new comments',
      'time': '2 d',
      'isRead': false,
    },
    {
      'icon': 'comment',
      'title': 'Post Content',
      'subtitle': '5 new comments',
      'time': '2 d',
      'isRead': false,
    },
  ];

  List<Map<String, dynamic>> eventNotifications = [
    {
      'icon': 'event',
      'title': 'University Fair',
      'subtitle': 'Join us at the MFU Job Fair 2025!',
      'time': '3 d',
      'isRead': false,
    },
    {
      'icon': 'event',
      'title': 'Music Festival',
      'subtitle': 'Live concert at the main hall tonight!',
      'time': '1 d',
      'isRead': false,
    },
    {
      'icon': 'event',
      'title': 'Orientation',
      'subtitle': 'Welcome new students to the university',
      'time': '5 h',
      'isRead': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void markPostAsRead(int index) {
    setState(() {
      postNotifications[index]['isRead'] = true;
    });
  }

  void markEventAsRead(int index) {
    setState(() {
      eventNotifications[index]['isRead'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.blue,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: "Post"),
                  Tab(text: "Event"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: postNotifications.length,
                    itemBuilder: (context, index) {
                      final item = postNotifications[index];
                      final isRead = item['isRead'] as bool;

                      return InkWell(
                        onTap: () => markPostAsRead(index),
                        child: Container(
                          color: isRead ? Colors.white : Colors.blue.shade50,
                          child: ListTile(
                            leading: Icon(
                              item['icon'] == 'bell'
                                  ? Icons.notifications_none
                                  : Icons.chat_bubble_outline,
                            ),
                            title: Text(item['title'] ?? ''),
                            subtitle: Text(item['subtitle'] ?? ''),
                            trailing: Text(item['time'] ?? ''),
                          ),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: eventNotifications.length,
                    itemBuilder: (context, index) {
                      final item = eventNotifications[index];
                      final isRead = item['isRead'] as bool;

                      return InkWell(
                        onTap: () => markEventAsRead(index),
                        child: Container(
                          color: isRead ? Colors.white : Colors.blue.shade50,
                          child: ListTile(
                            leading: const Icon(Icons.event_note),
                            title: Text(item['title'] ?? ''),
                            subtitle: Text(item['subtitle'] ?? ''),
                            trailing: Text(item['time'] ?? ''),
                          ),
                        ),
                      );
                    },
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
