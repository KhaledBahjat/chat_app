import 'package:chat_app/core/style/app_color.dart';
import 'package:chat_app/core/widgets/custom_button.dart';
import 'package:chat_app/core/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120.h,
                ),
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    width: 100.w,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                Text(
                  'Sign In',
                  style: TextStyle(fontSize: 40, color: AppColor.whiteColor),
                ),
                SizedBox(height: 15.h),
                CustomTextField(
                  hint: 'Email',
                ),
            
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  hint: 'Password',
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                    size: 30,
                    color: AppColor.whiteColor,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomButton(),
                SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

