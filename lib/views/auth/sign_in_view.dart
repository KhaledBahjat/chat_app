import 'dart:developer';

import 'package:chat_app/core/routing/app_routs.dart';
import 'package:chat_app/core/style/app_color.dart';
import 'package:chat_app/core/widgets/custom_button.dart';
import 'package:chat_app/core/widgets/custom_text_feild.dart';
import 'package:chat_app/core/widgets/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String? email, password;

  bool isObscure = true;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColor.primaryColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
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
                      'Sign In',
                      style: TextStyle(
                        fontSize: 40,
                        color: AppColor.whiteColor,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    CustomTextField(
                      keyboardType: TextInputType.emailAddress,
                      hint: 'Email',
                      onSaved: (data) => email = data,
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      onSaved: (value) => password = value,
                      keyboardType: TextInputType.visiblePassword,
                      hint: 'Password',
                      obscureText: isObscure,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility,
                          size: 30,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),

                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                  email: email!,
                                  password: password!,
                                );

                            if (!context.mounted) return;
                            GoRouter.of(context).pushNamed(AppRouts.chatView);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'invalid-email') {
                              // Methods.showMesseage(context, 'Invalid Email');
                              log('invalid-email');
                            } else if (e.code == 'user-not-found') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('User not found for this Email'),
                                ),
                              );
                            } else if (e.code == 'wrong-password') {
                              Methods.showMesseage(context, 'Wrong Password');
                            }
                          } catch (e) {
                            Methods.showMesseage(
                              context,
                              'Unexpected error during sign-in: $e',
                            );
                          }
                        }
                      },
                      label: 'Sign In',
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: AppColor.whiteColor),
                          ),
                          SizedBox(
                            width: 5.sp,
                          ),
                          InkWell(
                            onTap: () => GoRouter.of(
                              context,
                            ).pushNamed(AppRouts.registerView),
                            child: Text(
                              'Sign Up Now',
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
        ),
      ),
    );
  }

  Future<void> signInUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email!,
          password: password!,
        );
  }
}
