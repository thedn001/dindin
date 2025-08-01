import 'package:dindin_app/feed/home/fullpost.dart';
import 'package:dindin_app/feed/report.dart';
import 'package:flutter/material.dart';

class PostInfo extends StatefulWidget {
  final int postId;
  final String pfImage;
  final String text;
  final String? image;
  final int catId;
  final String categoryName;
  final int userRole; // 1=user, 2=admin, 3=staff
  final int postUserId;

  const PostInfo({
    super.key,
    required this.postId,
    required this.pfImage,
    required this.text,
    this.image,
    required this.catId,
    required this.categoryName,
    required this.userRole,
    required this.postUserId,
  });

  @override
  State<PostInfo> createState() => _PostInfoState();
}

class _PostInfoState extends State<PostInfo> {
  bool isToggled = false;
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ViewFullpost(
              postId: widget.postId,
              pfImage: widget.pfImage,
              text: widget.text,
              image: widget.image,
              catId: widget.catId,
              categoryName: widget.categoryName,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile image
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundImage: AssetImage(widget.pfImage),
                    radius: 33,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category and options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: Text(
                            widget.categoryName,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTapDown: (details) {
                            const int currentUserId = 2;
                            // ส่งค่าที่ได้รับจาก widget มาที่ฟังก์ชัน morevert()
                            morevert(
                              context,
                              widget.userRole,
                              widget.postUserId,
                              currentUserId,
                              details.globalPosition,
                            );
                          },
                          child: const Icon(Icons.more_vert_outlined),
                        ),
                      ],
                    ),
                    // Text content
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        widget.text,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    // Post image
                    if (widget.image?.isNotEmpty == true)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Image.asset(
                          widget.image!,
                          width: 300,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Like, comment
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isToggled = !isToggled;
                                });
                              },
                              icon: Icon(
                                Icons.favorite,
                                color:
                                    isToggled ? Colors.red : Colors.grey[700],
                              ),
                            ),
                            const Text('20'),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ViewFullpost(
                                      postId: widget.postId,
                                      pfImage: widget.pfImage,
                                      text: widget.text,
                                      image: widget.image,
                                      catId: widget.catId,
                                      categoryName: widget.categoryName,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.comment,
                                  size: 25, color: Colors.grey[700]),
                            ),
                            const Text('20'),
                          ],
                        ),
                        // Bookmark, share
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isBookmarked = !isBookmarked;
                                  });
                                },
                                icon: Icon(
                                  isBookmarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: isBookmarked
                                      ? Colors.amber
                                      : Colors.grey[700],
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.ios_share_sharp,
                                    color: Colors.grey[700], size: 25),
                              ),
                            ],
                          ),
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
    );
  }
}

void morevert(BuildContext context, int userRole, int postUserId,
    int currentUserId, Offset offset) async {
  List<PopupMenuEntry<String>> menuItems = [];

  if (userRole == 1) {
    if (postUserId == currentUserId) {
      // เป็นโพสต์ของตัวเอง => Delete
      menuItems.add(
        const PopupMenuItem(
          value: 'delete',
          child: Center(
              child: Text('Delete', style: TextStyle(color: Colors.red))),
        ),
      );
    } else {
      // โพสต์คนอื่น => Report
      menuItems.add(
        const PopupMenuItem(
          value: 'report',
          child: Center(
              child: Text('Report', style: TextStyle(color: Colors.red))),
        ),
      );
    }
  } else if (userRole == 2) {
    // admin ลบโพสต์คนอื่น
    menuItems.add(
      const PopupMenuItem(
        value: 'admin_delete',
        child:
            Center(child: Text('Delete', style: TextStyle(color: Colors.red))),
      ),
    );
  }

  final result = await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    items: menuItems,
  );

  if (result == null) return;

  switch (result) {
    case 'report':
      debugPrint('reported');
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 100),
          reverseTransitionDuration: const Duration(milliseconds: 100),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ReportPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
      break;

    case 'delete':
      final deleteResult = await showDialogDelete(context);
      if (deleteResult == 'deleted') {
        debugPrint('deleted by user');
      } else {
        debugPrint('user canceled delete');
      }
      break;

    case 'admin_delete':
      final reason = await showDialogAdmin(context);
      if (reason != null) {
        debugPrint('deleted by admin, reason: $reason');
      } else {
        debugPrint('admin canceled delete');
      }
      break;
  }
}

// dlt own post
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
              'Delete post?',
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

// admin dlt
Future<String?> showDialogAdmin(BuildContext context) async {
  String dropdownValue = 'Scam';

  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
                child: Text(
                  'Delete post?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              // Dropdown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: DropdownButtonFormField<String>(
                  value: dropdownValue,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                  ),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    }
                  },
                  items: ['Scam', 'Bullying', 'Suicide']
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(height: 1.0, thickness: 0.5, color: Colors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                    child: VerticalDivider(width: 1, thickness: 0.5),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context, dropdownValue),
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    ),
  );
}
