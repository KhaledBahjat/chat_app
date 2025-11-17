import 'package:chat_app/core/style/app_color.dart';
import 'package:chat_app/core/widgets/chat_bubbel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
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
                itemCount: 20,

                itemBuilder: (context, index) {
                  return ChatBubbel();
                },
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              color: Colors.grey[200],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
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
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
