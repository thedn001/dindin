import 'package:flutter/material.dart';

class Termsread extends StatefulWidget {
  const Termsread({super.key});

  @override
  State<Termsread> createState() => _TermsreadState();
}

class _TermsreadState extends State<Termsread> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blueGrey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Terms of service",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[800],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Privacy Policy",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 600,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(135, 122, 119, 119)),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12),
                child: const SingleChildScrollView(
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ...",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
