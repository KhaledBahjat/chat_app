import 'package:chat_app/core/routing/app_routs.dart';
import 'package:chat_app/core/style/app_color.dart';
import 'package:chat_app/core/widgets/custom_button.dart';
import 'package:chat_app/core/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'KLMNA',
                    style: TextStyle(fontSize: 40.sp),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 40, color: AppColor.whiteColor),
                ),
                SizedBox(height: 15.h),
                CustomTextField(hint: 'Email'),

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
                CustomButton(label: 'Sign Up',),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Alredy have an account?',
                        style: TextStyle(color: AppColor.whiteColor),
                      ),
                      SizedBox(
                        width: 5.sp,
                      ),
                      InkWell(
                        onTap: () =>GoRouter.of(context).pushNamed(AppRouts.signInView),
                        child: Text(
                          'Sign In Now',
                          style: TextStyle(color: AppColor.whiteColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
