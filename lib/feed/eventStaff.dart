import 'package:dindin_app/addevent.dart';
import 'package:dindin_app/feed/event.dart';
import 'package:flutter/material.dart';

class Eventstaff extends StatefulWidget {
  final int userRole;
  const Eventstaff({super.key, required this.userRole});

  @override
  State<Eventstaff> createState() => _EventstaffState();
}

class _EventstaffState extends State<Eventstaff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Event(userRole: widget.userRole),

     floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 100), // speed
                reverseTransitionDuration: const Duration(milliseconds: 100),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const Addevent(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin =
                      Offset(0.0, 1.0); // (x, y) 1.0 = เลื่อนจากล่างขึ้นมา
                  const end = Offset.zero; //
                  final tween = Tween(begin: begin, end: end);

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                }),
          );
        },
        backgroundColor: Colors.amber[600],
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}