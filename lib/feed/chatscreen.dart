import 'package:flutter/material.dart';

class Chatscreen extends StatefulWidget {
  final String userName;
   const Chatscreen({super.key, required this.userName});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
final List<Map<String, dynamic>> messages = [
    {
      'text': 'Hellooo :)',
      'isMe': false,
      'time': '10.23',
    },
    {
      'text': 'What’s your name?',
      'isMe': false,
      'time': '10.23',
    },
    {
      'text': 'Hi there!',
      'isMe': true,
      'time': '10.25',
    },
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({
        'text': text,
        'isMe': true,
        'time': TimeOfDay.now().format(context),
      });
      _controller.clear();
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  Widget _buildMessage(Map<String, dynamic> msg) {
    bool isMe = msg['isMe'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMe)
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: Color(0xFF2E3B4E),
                ),
              if (!isMe) const SizedBox(width: 6),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.grey[200] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(msg['text']),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text(
              msg['time'],
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDate() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          '1/1/2025',
          style: TextStyle(fontSize: 12, color: Colors.black87),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.userName,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2E3B4E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return _buildDate();
                  return _buildMessage(messages[index - 1]);
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            color: const Color(0xFF384959),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Aa',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
