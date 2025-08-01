import 'package:flutter/material.dart';

class Terms extends StatefulWidget {
  final VoidCallback onAccepted;
  const Terms({super.key, required this.onAccepted});

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Terms of service",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
              const SizedBox(height: 10),
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
                height: 400,
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
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      "I agree to all terms and condition.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isChecked ? widget.onAccepted : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isChecked ? Colors.amber[700] : Colors.grey,
                    disabledBackgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const StadiumBorder(),
                    foregroundColor: Colors.blueGrey,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child: const Text("Next"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
