import 'package:flutter/material.dart';

class StBookmark extends StatefulWidget {
  const StBookmark({super.key});

  @override
  State<StBookmark> createState() => _StBookmarkState();
}

class _StBookmarkState extends State<StBookmark> {
  final List<Map<String, dynamic>> posts = [
    {
     "postId": 101,
      "Pfimage": "assets/images/ym.jpg",
      "text": "text",
      "image": "assets/images/ym.jpg",
      'Catid': 1,
      'Name': 'General'
    },
    // {
    //   "postId": 104,
    //   "Pfimage": "assets/images/384959.png",
    //   "text": "No.03",
    //   "image": "assets/images/salad.jpg",
    //   'Catid': 1,
    //   'Name': 'Love & relationship'
    // },
  ];

  late List<bool> isLiked;
  late List<bool> isBookmarked;

  @override
  void initState() {
    super.initState();
    isLiked = List.filled(posts.length, false);
    // bookmark เริ่มต้น
    isBookmarked = List.filled(posts.length, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Bookmark')),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(),
        ),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(post['Pfimage']),
                        radius: 33,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  post['Name'],
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.more_vert_outlined),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            // Text
                            Text(post['text']),
                            const SizedBox(height: 8),
                            // Image
                            Image.asset(
                              post['image'],
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 8),
                            // Action buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isLiked[index] = !isLiked[index];
                                        });
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: isLiked[index]
                                            ? Colors.red
                                            : Colors.grey[700],
                                      ),
                                    ),
                                    const Text('20'),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.comment,
                                          color: Colors.grey[700]),
                                    ),
                                    const Text('20'),
                                  ],
                                ),
                                // boookmark
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isBookmarked[index] =
                                              !isBookmarked[index];
                                        });
                                      },
                                      icon: Icon(
                                        isBookmarked[index]
                                            ? Icons.bookmark
                                            : Icons.bookmark_border,
                                        color: isBookmarked[index]
                                            ? Colors.amber
                                            : Colors.grey[700],
                                      ),
                                    ),
                                    // share
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.ios_share_sharp,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
