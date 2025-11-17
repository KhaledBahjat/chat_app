import 'package:chat_app/core/style/app_color.dart';
import 'package:chat_app/core/widgets/chat_bubbel.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/logo.png",
              height: 30,
            ),
            const SizedBox(width: 8),
            const Text("Chat App"),
          ],
        ),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: ChatBubbel(),
    );
  }
}

