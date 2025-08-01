import 'package:dindin_app/slidetab/termsread.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

// มีการเเก้ไขบ่
bool hasUnsavedChanges = false;

class _SettingState extends State<Setting> {
  String displayName = "Admin_1";
  final TextEditingController _nameController = TextEditingController();
  bool isEditingName = false;

  // รูปโปรไฟล์จาก assets
  String? _selectedAssetImage;

  final List<String> availableImages = [
    'assets/images/profile/pfp01.jpg',
    'assets/images/profile/pfp02.jpg',
    'assets/images/profile/pfp03.jpg',
    'assets/images/profile/pfp04.jpg',
    'assets/images/profile/pfp05.jpg',
    'assets/images/profile/pfp06.jpg',
    'assets/images/profile/pfp07.jpg',
    'assets/images/profile/pfp08.jpg',
    'assets/images/profile/pfp09.jpg',
    'assets/images/profile/pfp10.jpg',
    'assets/images/profile/pfp11.jpg',
    'assets/images/profile/pfp12.jpg',
    'assets/images/profile/pfp13.jpg',
    'assets/images/profile/pfp14.jpg',
    'assets/images/profile/pfp15.jpg',
    'assets/images/profile/pfp16.jpg',
    // 'assets/profile3.png',
    // 'assets/profile4.png',
  ];

  // เปลี่ยนชื่อ
  @override
  void initState() {
    super.initState();
    _nameController.text = displayName;
  }

  // เลือกรูป
  void _showImageSelector() {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
              child: Text(
                'Select profile image',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),

            SizedBox(
              height: 180,
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: availableImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // ให้รูปเรียงกันได้ 4 รูปต่อแถว
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final img = availableImages[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAssetImage = img;
                        hasUnsavedChanges = true;
                      });
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage(img),
                    ),
                  );
                },
              ),
            ),
            const Divider(
              height: 1.0,
              thickness: 0.5,
              color: Colors.grey,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Cancel',
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
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: hasUnsavedChanges
                ? () {
                    setState(() {
                      hasUnsavedChanges = false;
                      isEditingName = false;
                    });
                    Navigator.pop(context);
                  }
                : null, // ถ้ายังไม่เเก้ไขจะไม่ทำงาน
            child: Text(
              'SAVE',
              style: TextStyle(
                color: hasUnsavedChanges ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            height: 1.0,
            thickness: 1.0,
            color: Colors.grey.shade300,
          ),
        ),
      ),
      body: Column(
        // edit img
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _showImageSelector,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: _selectedAssetImage != null
                            ? AssetImage(_selectedAssetImage!)
                            : null,
                        child: _selectedAssetImage == null
                            ? const Icon(Icons.edit, color: Colors.white)
                            : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isEditingName
                          ? Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _nameController,
                                    autofocus: true, // กดแล้วแป้นเด้งเลย
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                    ),
                                    onSubmitted: (value) {
                                      // กด enter เลย
                                      setState(() {
                                        // เเก้ชื่อแล้วส่งไปที่ displayName
                                        displayName = value.trim();
                                        isEditingName = false;
                                        hasUnsavedChanges = true;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          // กดที่ชื่อเพื่อเเก้
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEditingName = true;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    displayName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.edit,
                                      size: 16, color: Colors.grey),
                                ],
                              ),
                            ),
                      const Text(
                        'ID',
                        style: TextStyle(color: Colors.lightBlue), // 87BDF1
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.grey.shade300),
          // Terms of service
          ListTile(
            title: const Text("Terms of service"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration:
                      const Duration(milliseconds: 100), // speed
                  reverseTransitionDuration: const Duration(milliseconds: 100),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const Termsread(), // terms page rea only
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
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
            },
          ),
          // Contact us
          ListTile(
            title: const Text("Contact us"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final url = Uri.parse('https://reg.mfu.ac.th/contact-us');

              if (await canLaunchUrl(url)) {
                debugPrint('launch url');
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                debugPrint('Could not launch URL');
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('Could not launch URL')),
                // );
              }
            },
          ),
        ],
      ),
    );
  }
}
