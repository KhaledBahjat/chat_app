import 'package:chat_app/core/style/app_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagesBar extends StatelessWidget {
  const MessagesBar({
    super.key,
    required this.messageController,
    required this.messages,
  });

  final TextEditingController messageController;
  final CollectionReference<Object?> messages;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      color: Colors.grey[200],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              onSubmitted: (value) {
                messages.add({
                  'body': value,
                });
                messageController.clear();
              },
              decoration: InputDecoration(
                hintText: "Type a message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          CircleAvatar(
            radius: 24.r,
            backgroundColor: AppColor.primaryColor,
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: () {
                messages.add({
                  'body': messageController.text,
                });
                messageController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
