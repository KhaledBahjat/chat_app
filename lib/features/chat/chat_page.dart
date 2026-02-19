import 'package:chat_app/core/widgets/spacing.dart';
import 'package:chat_app/features/auth/sign_in.dart';
import 'package:chat_app/features/chat/widget/bouble_chat.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Image.asset('assets/image/logo.png'),
              ),
              SizedBox(width: 10),
              Text(
                'Chatna',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
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
        body: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
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
                  ChatBubble(
                    message: "كيف حالك؟",
                    sender: false,
                    time: "10:32 AM",
                  ),
                  ChatBubble(
                    message: "أنا بخير، شكراً لسؤالك! كيف يمكنني مساعدتك اليوم؟",
                    sender: true,
                    time: "10:33 AM",
                  ),
                  ChatBubble(
                    message: "مع السلامة",
                    sender: false,
                    time: "10:34 AM",
                  ),
                ],
              ),
            ),
            messageBar(),
          ],
        ),
      ),
    );
  }

  MessageBar messageBar() {
    return MessageBar(
            onSend: (valu) {},
            actions: [
              InkWell(
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 24,
                ),
                onTap: () {},
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: InkWell(
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.green,
                    size: 24,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          );
  }
}
