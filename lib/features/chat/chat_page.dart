import 'dart:developer';

import 'package:chat_app/core/helper/constant.dart';
import 'package:chat_app/features/chat/widget/bouble_chat.dart';
import 'package:chat_app/features/chat/widget/coustom_drawer.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  static const String id = 'chatPage';
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: messages.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          log(snapshot.data!.docs[0]['message']);
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              endDrawer: CustomDrawer(),
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
                          message:
                              "أنا بخير، شكراً لسؤالك! كيف يمكنني مساعدتك اليوم؟",
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
                  MessageBar(
                    onSend: (value) {
                      messages.add({
                        'message': value,
                        'createdAt': FieldValue.serverTimestamp(),
                        'senderId': FirebaseAuth.instance.currentUser!.email,
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
