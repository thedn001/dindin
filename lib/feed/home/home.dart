import 'package:dindin_app/addpost.dart';
import 'package:dindin_app/feed/home/categories.dart';
import 'package:dindin_app/feed/home/postInfo.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearchClicked = false;
  final TextEditingController _searchController = TextEditingController();
  final int userRole = 1;

  // categories
  final categories = [
    {'Catid': 1, 'Name': 'General'},
    {'Catid': 2, 'Name': 'Education'},
    {'Catid': 3, 'Name': 'Health & beauty'},
    {'Catid': 4, 'Name': 'Love & relationship'},
    {'Catid': 5, 'Name': 'Arts'},
    {'Catid': 6, 'Name': 'Hobby'},
    {'Catid': 7, 'Name': 'Market'},
  ];

  // post info
  final List<Map<String, dynamic>> posts = [
    {
      "postId": 101,
      "Pfimage": "assets/images/ym.jpg",
      "text": "text",
      "image": "assets/images/ym.jpg",
      'Catid': 1,
      'Name': 'General',
      'UserId': 1,
    },
    {
      "postId": 102,
      "Pfimage": "assets/images/ym.jpg",
      "text": "Lorem Ipsum is simply dummy text...",
      "image": "",
      'Catid': 1,
      'Name': 'Arts',
      'UserId': 2,
    },
    {
      "postId": 103,
      "Pfimage": "assets/images/ym.jpg",
      "text": "Lorem Ipsum is simply dummy text...",
      "image": "",
      'Catid': 1,
      'Name': 'Arts',
      'UserId': 3,
    },
    {
      "postId": 103,
      "Pfimage": "assets/images/ym.jpg",
      "text": "Lorem Ipsum is simply dummy text...",
      "image": "",
      'Catid': 1,
      'Name': 'Arts',
      'UserId': 3,
    },
    {
      "postId": 103,
      "Pfimage": "assets/images/ym.jpg",
      "text": "Lorem Ipsum is simply dummy text...",
      "image": "",
      'Catid': 1,
      'Name': 'Arts',
      'UserId': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Expanded(
              // Sreach bar
              child: isSearchClicked
                  ? Container(
                      height: 40,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (context) {},
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          hintText: "Search. . .",
                        ),
                      ),
                    )
                  // show catergories
                  : SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                final datacat = categories[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Categories(
                                    catId: datacat['Catid'] as int,
                                    categoryName: datacat['Name'] as String,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            // Icon for search and cancels
            IconButton(
              icon: Icon(isSearchClicked ? Icons.close : Icons.search),
              color: Colors.black,
              onPressed: () {
                setState(() {
                  isSearchClicked = !isSearchClicked;
                  if (!isSearchClicked) {
                    _searchController.clear();
                  }
                });
              },
            ),
          ],
        ),
        // เส้นใต้categories
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(
            height: 1,
          ),
        ),
      ),

      // body in postinfomation
      body: SingleChildScrollView(
        child: Container(
          // bg color behind card
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: ListView.builder(
                  // shrinkWrap and physics ใช้เพื่อนscrollจนสุดท้าย
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final data = posts[index];
                    return PostInfo(
                      postId: data['postId'] as int,
                      pfImage: data['Pfimage'] as String,
                      text: data['text'] as String,
                      image: data['image'] as String?,
                      catId: data['Catid'] as int,
                      categoryName: data['Name'] as String,
                      userRole: userRole,
                      postUserId: data['UserId'] as int,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 100), // speed
                reverseTransitionDuration: const Duration(milliseconds: 100),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const Addpost(),
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
