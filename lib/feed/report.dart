import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String? _selectedReason;
  final TextEditingController _othersController = TextEditingController();

  final List<String> _reportReasons = [
    "Scam",
    "Bullying",
    "Suicide",
    "Violence",
    "Sexual activity",
    "Others"
  ];

  bool get _isSendEnabled {
    if (_selectedReason == null) return false;
    if (_selectedReason == "Others" && _othersController.text.trim().isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _othersController.addListener(() {
      setState(() {}); // อัปเดตปุ่มเมื่อพิมพ์ในช่อง Others
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "report",
          style: TextStyle(fontWeight: FontWeight.bold),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Why are you reporting this post?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 14),

            // Radio buttons
            ..._reportReasons.map((reason) => RadioListTile(
                  contentPadding: const EdgeInsets.only(left: 0),
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  activeColor: const Color(0xFF384959),
                  title: Text(reason),
                  value: reason,
                  groupValue: _selectedReason,
                  onChanged: (value) {
                    setState(() {
                      _selectedReason = value.toString();
                    });
                  },
                )),

            // Others input
            if (_selectedReason == "Others")
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _othersController,
                        maxLines: 5,
                        maxLength: 150,
                        decoration: const InputDecoration(
                          hintText: "Type here...",
                          border: InputBorder.none,
                          counterText: "",
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${_othersController.text.length}/150",
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isSendEnabled
                        ? const Color(0xFF8E1616)
                        : Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: _isSendEnabled
                      ? () {
                          debugPrint("Report reason: $_selectedReason");
                          if (_selectedReason == "Others") {
                            debugPrint("Other reason: ${_othersController.text}");
                          }
                          final reportResult = _selectedReason == "Others"
                              ? _othersController.text
                              : _selectedReason;

                          Navigator.pop(context, reportResult);
                        }
                      : null,
                  child: const Text(
                    "SEND",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}