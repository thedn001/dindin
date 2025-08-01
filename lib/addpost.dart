import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Addpost extends StatefulWidget {
  const Addpost({super.key});

  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {
  String? SelectCategory = "General";
  bool DropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appbar(),
        body: _body(),
      ),
    );
  }

// AppBar
  PreferredSizeWidget _appbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Cancel button
          TextButton(
            onPressed: () {
               Navigator.pop(context);
            },
            child: const Text(
              'CANCEL',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),

          // Dindin logo
          Image.asset(
            'assets/images/dindin.png',
            width: 40,
          ),

          // Post button
          ElevatedButton(
            onPressed: () {
              setState(() {
                // *****************
              });
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
    );
  }

// body
  Widget _body() {
    final List<String> categories = [
      'General',
      'Education',
      'Sport & Health',
      'Beauty',
      'Love & relationship',
      'Arts',
    ];

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown
            GestureDetector(
              onTap: () {
                setState(() {
                  DropdownOpen = true;
                });
                _showCategory(context, categories);
              },
              child: Row(
                children: [
                  const Icon(Icons.face),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            SelectCategory ?? "General",
                            style: const TextStyle(fontSize: 16),
                          ),
                          Icon(
                            DropdownOpen
                                ? Icons.arrow_drop_up // true
                                : Icons.arrow_drop_down, //false
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade300),
            const SizedBox(height: 20),

            // Text Input
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'What are you thinking?',
                border: InputBorder.none,
              ),
              maxLength: 150,
              maxLines: null,
              buildCounter: (
                BuildContext context, {
                required int currentLength,
                required bool isFocused,
                required int? maxLength,
              }) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  // Image Upload
                  children: [
                    const Icon(Icons.image_outlined),
                    Text("$currentLength / $maxLength"),
                  ],
                );
              },
            ),

            const SizedBox(height: 10),
            Divider(height: 1, color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }

  void _showCategory(BuildContext context, List<String> categories) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Select your topic',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),

              // categories
              Expanded(
                child: ListView.separated(
                  itemCount: categories.length,
                  separatorBuilder: (_, __) =>
                      Divider(height: 1, color: Colors.grey.shade300),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return RadioListTile<String>(
                      title: Text(category),
                      value: category,
                      groupValue: SelectCategory,
                      onChanged: (value) {
                        setState(() {
                          SelectCategory = value;
                          DropdownOpen = false;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      setState(() {
        DropdownOpen = false;
      });
    });
  }
}
