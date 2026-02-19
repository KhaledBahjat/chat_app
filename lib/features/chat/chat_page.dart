import 'package:chat_app/features/auth/sign_in.dart';
import 'package:chat_app/features/chat/widget/bouble_chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  static const String id = 'chatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Image.asset('assets/image/logo.png'),
            ),
            SizedBox(width: 10),
            Text('Chatna', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Cairo')),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, SignIn.id);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
  children: const [
    ChatBubble(
      message: "السلام عليكم",
      sender: false,
      time: "10:30 AM",
    ),
    ChatBubble(
      message: "وعليكم السلام يا بطل 🔥",
      sender: true,
      time: "10:31 AM",
    ),
  ],
),
    );
  }
}
