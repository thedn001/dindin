import 'package:dindin_app/feed/chat.dart';
import 'package:dindin_app/feed/event.dart';
import 'package:dindin_app/feed/home/home.dart';
import 'package:dindin_app/feed/noti.dart';
import 'package:dindin_app/login.dart';
import 'package:dindin_app/slidetab/setting.dart';
import 'package:dindin_app/slidetab/st_bookmark.dart';
import 'package:dindin_app/slidetab/st_post.dart';
import 'package:dindin_app/slidetab/st_response.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  final int userId;
  final int userRole;

  const Navbar({
    super.key,
    required this.userId,
    required this.userRole,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool light0 = true;
  bool light1 = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Container(
              child: Image.asset(
                'assets/images/dindin.png',
                width: 40,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Divider(
              height: 2,
            ),
          ),
        ),
        // sidetab
        drawer: Drawer(
          child: Column(
            children: [
              const DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/profile/pfp01.jpg'),
                                radius: 33,
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'username',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '6531501000',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration: const Duration(
                                      milliseconds: 100), // speed
                                  reverseTransitionDuration:
                                      const Duration(milliseconds: 100),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const StPost(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(0.0,
                                        1.0); // (x, y) 1.0 = เลื่อนจากล่างขึ้นมา
                                    const end = Offset.zero; //
                                    final tween = Tween(begin: begin, end: end);

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  }),
                            );
                          },
                          icon: const Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          label: const Text(
                            'Post',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration: const Duration(
                                        milliseconds: 100), // speed
                                    reverseTransitionDuration:
                                        const Duration(milliseconds: 100),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const StResponse(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(0.0,
                                          1.0); // (x, y) 1.0 = เลื่อนจากล่างขึ้นมา
                                      const end = Offset.zero; //
                                      final tween =
                                          Tween(begin: begin, end: end);

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    }),
                              );
                            },
                            icon: const Icon(
                              Icons.replay_outlined,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Response',
                              style: TextStyle(color: Colors.black),
                            )),
                        TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration: const Duration(
                                        milliseconds: 100), // speed
                                    reverseTransitionDuration:
                                        const Duration(milliseconds: 100),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const StBookmark(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(0.0,
                                          1.0); // (x, y) 1.0 = เลื่อนจากล่างขึ้นมา
                                      const end = Offset.zero; //
                                      final tween =
                                          Tween(begin: begin, end: end);

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    }),
                              );
                            },
                            icon: const Icon(
                              Icons.bookmark,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Bookmark',
                              style: TextStyle(color: Colors.black),
                            )),
                        TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration: const Duration(
                                        milliseconds: 100), // speed
                                    reverseTransitionDuration:
                                        const Duration(milliseconds: 100),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const Setting(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(0.0,
                                          1.0); // (x, y) 1.0 = เลื่อนจากล่างขึ้นมา
                                      const end = Offset.zero; //
                                      final tween =
                                          Tween(begin: begin, end: end);

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    }),
                              );
                            },
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Setting',
                              style: TextStyle(color: Colors.black),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Row(
                            children: [
                              Icon(
                                Icons.light_mode,
                                color: light1 ? Colors.grey : Colors.amber,
                              ),
                              Switch(
                                  value: light1,
                                  onChanged: (bool value) {
                                    setState(() {
                                      light1 = value;
                                    });
                                  }),
                              Icon(
                                Icons.dark_mode,
                                color: light1
                                    ? Colors.deepPurpleAccent[800]
                                    : Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                              );
                            },
                            icon: const Icon(
                              Icons.logout_outlined,
                              color: Colors.red,
                            ),
                            label: const Text(
                              'Logout',
                              style: TextStyle(color: Colors.red),
                            ))
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

        // link pages
        body: TabBarView(
          children: [
            Home(),
            Event(userRole: widget.userRole),
            Noti(),
            Chat(),
          ],
        ),

        // navbar
        bottomNavigationBar: Container(
          color: const Color(0xFF384959),
          child: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF384959),
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.event_rounded),
                text: 'Event',
              ),
              Tab(
                icon: Icon(Icons.notifications_none),
                text: 'Notification',
              ),
              Tab(
                icon: Icon(Icons.chat),
                text: 'Chat',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
