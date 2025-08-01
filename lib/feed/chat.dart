import 'package:dindin_app/feed/chatscreen.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> with SingleTickerProviderStateMixin {
   late TabController _tabController;

  List<ChatMessage> messages = [
    ChatMessage(
      avatarPath: 'assets/images/profile/pfp01.jpg',
      name: 'User1',
      lastMessage: 'You: Hey!',
      time: '17s',
    ),
    ChatMessage(
      avatarPath: 'assets/images/profile/pfp02.jpg',
      name: 'User2',
      lastMessage: 'You: Hello there!',
      time: '5m',
    ),
    ChatMessage(
      avatarPath: 'assets/images/profile/pfp03.jpg',
      name: 'User3',
      lastMessage: 'User3: I\'m doing well, thanks!',
      time: '2h',
      isRead: false,
    ),
  ];

  List<ChatRequest> requests = [
    ChatRequest(
      avatarPath: 'assets/images/profile/pfp01.jpg',
      name: 'User5',
      message: 'Hi! I have a quick question.',
      time: '2s',
    ),
    ChatRequest(
      avatarPath: 'assets/images/profile/pfp04.jpg',
      name: 'User6',
      message: 'Hello! Can we chat for a bit?',
      time: '50m',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void onAccept(int index) {
    setState(() {
      requests[index].isAccepted = true;
      messages.add(ChatMessage(
        avatarPath: requests[index].avatarPath,
        name: requests[index].name,
        lastMessage: 'You accepted the chat request.',
        time: 'now',
        isRead: true,
      ));
    });
  }

  void onReject(int index) {
    setState(() {
      requests.removeAt(index);
    });
  }

  Widget buildMessageTile(ChatMessage msg) {
    return InkWell(
      onTap: () {
        setState(() {
          msg.isRead = true;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Chatscreen(userName: msg.name),
          ),
        );
      },
      child: Container(
        color: msg.isRead ? null : Colors.blue[100],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(msg.avatarPath),
                    radius: 30,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        msg.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(msg.lastMessage),
                    ],
                  ),
                  const Spacer(),
                  Text(msg.time),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget buildRequestTile(ChatRequest req, int index) {
    return InkWell(
      onTap: () {
        if (req.isAccepted == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Chatscreen(userName: req.name),
            ),
          );
        }
      },
      child: Container(
        color: req.isAccepted == true ? Colors.blue[100] : null,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (req.isAccepted == null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => onAccept(index),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            textStyle: const TextStyle(fontSize: 12),
                          ),
                          child: const Text('ACCEPT'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => onReject(index),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 151, 180, 255),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            textStyle: const TextStyle(fontSize: 12),
                          ),
                          child: const Text('REJECT'),
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(req.avatarPath),
                        radius: 30,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              req.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(req.message),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(req.time),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Message'),
              Tab(text: 'Request'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return buildMessageTile(messages[index]);
                  },
                ),
                ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    return buildRequestTile(requests[index], index);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Models ----------------

class ChatMessage {
  final String avatarPath;
  final String name;
  final String lastMessage;
  final String time;
  bool isRead;

  ChatMessage({
    required this.avatarPath,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.isRead = true,
  });
}

class ChatRequest {
  final String avatarPath;
  final String name;
  final String message;
  final String time;
  bool? isAccepted;

  ChatRequest({
    required this.avatarPath,
    required this.name,
    required this.message,
    required this.time,
    this.isAccepted,
  });
}
