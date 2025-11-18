import 'dart:developer';

import 'package:chat_app/core/style/app_color.dart';
import 'package:chat_app/core/widgets/chat_bubbel.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/views/chat/widgets/messeage_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages = FirebaseFirestore.instance.collection(
    'messages',
  );
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: messages.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
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
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      // physics: BouncingScrollPhysics(),
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return ChatBubbel(
                          message: messagesList[index],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  MessagesBar(
                    messageController: messageController,
                    messages: messages,
                  ),
                ],
              ),
            ),
          );
        } else {
          return CupertinoActivityIndicator(
            color: AppColor.primaryColor,
          );
        }
      },
    );
  }
}
