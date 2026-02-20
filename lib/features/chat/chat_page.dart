import 'dart:developer';

import 'package:chat_app/core/helper/constant.dart';
import 'package:chat_app/features/chat/widget/bouble_chat.dart';
import 'package:chat_app/features/chat/widget/coustom_drawer.dart';
import 'package:chat_app/features/chat/widget/loading_widget.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  static const String id = 'chatPage';
  final _controller = ScrollController();
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: false).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> listMessages = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            listMessages.add(MessageModel.fromJson(snapshot.data!.docs[i]));
          }
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
                    child: ListView.builder(
                      controller: _controller,
                      itemBuilder: (context, index) {
                        return ChatBubble(
                          message: listMessages[index].message,
                          sender:
                              listMessages[index].senderId ==
                              FirebaseAuth.instance.currentUser!.email,
                          time: DateFormat('hh:mm a').format(
                            listMessages[index].createdAt.toDate(),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: listMessages.length,
                    ),
                  ),

                  MessageBar(
                    onSend: (value) {
                      messages.add({
                        'message': value,
                        'createdAt': FieldValue.serverTimestamp(),
                        'senderId': FirebaseAuth.instance.currentUser!.email,
                      });
                      _controller.animateTo(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.easeInOut,
                        _controller.position.maxScrollExtent,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}
