import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/core/theme/app_color.dart';
import 'package:chat_app/core/widgets/spacing.dart';
import 'package:chat_app/features/widgets/custom_button.dart';
import 'package:chat_app/features/widgets/custom_text_feild.dart';
import 'package:chat_app/features/widgets/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatefulWidget {
  static const String id = 'SignUp';
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  @override
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  GlobalKey<FormState> formstate = GlobalKey();
  bool isLoading = false;
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                  strokeWidth: 2,
                ),
              )
            : Padding(
                padding: EdgeInsets.all(20),
                child: ListView(
                  children: [
                    Form(
                      key: formstate,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeightSpace(70),
                          Logo(),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Sign Up to Chatna",
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Pacifico',
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'Create an account to continue chatting with your friends',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          HeightSpace(10),
                          TextFieldWidget(
                            onSubmitted: (data) {
                              nameController.text = data;
                            },
                            controller: nameController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Enter your name';
                              }
                              return null;
                            },
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Enter your name',
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          HeightSpace(10),
                          // email textfield
                          TextFieldWidget(
                            onSubmitted: (data) {
                              emailController.text = data;
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Enter your email';
                              }
                              return null;
                            },
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Enter your email',
                            controller: emailController,
                          ),

                          SizedBox(
                            height: 20.h,
                          ),

                          Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          HeightSpace(10),
                          TextFieldWidget(
                            onSubmitted: (data) {
                              passwordController.text = data;
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Enter your password';
                              }
                              return null;
                            },
                            obscureText: isObscure,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                              icon: isObscure
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                            hintText: 'Enter your password',
                            controller: passwordController,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    // sign up button
                    CustomButton(
                      title: 'Sign Up',
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'Success',
                            desc: 'Your account has been created successfully.',
                            btnOkOnPress: () {},
                          ).show();
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'weak-password',
                              desc: 'The password provided is too weak.',
                              btnOkOnPress: () {},
                            ).show();
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'email-already-in-use',
                              desc:
                                  'The account already exists for that email.',
                              btnOkOnPress: () {},
                            ).show();
                            print('The account already exists for that email.');
                          } else if (e.code == 'invalid-email') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'invalid-email',
                              desc: 'The email address is badly formatted.',
                              btnOkOnPress: () {},
                            ).show();
                            print('The email address is badly formatted.');
                          } else if (e.code == 'operation-not-allowed') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'operation-not-allowed',
                              desc: 'Email/Password accounts are not enabled.',
                              btnOkOnPress: () {},
                            ).show();
                            print('Email/Password accounts are not enabled.');
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.orange.shade200,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
