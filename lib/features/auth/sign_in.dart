import 'package:chat_app/core/helper/show_message.dart';
import 'package:chat_app/core/theme/app_color.dart';
import 'package:chat_app/core/widgets/spacing.dart';
import 'package:chat_app/features/auth/sign_up.dart';
import 'package:chat_app/features/chat/chat_page.dart';
import 'package:chat_app/features/auth/widgets/custom_button.dart';
import 'package:chat_app/features/auth/widgets/custom_text_feild.dart';
import 'package:chat_app/features/auth/widgets/logo.dart';
import 'package:chat_app/features/auth/widgets/show_forget_password_dialog_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  static const String id = 'signIn';
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
Future signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  await GoogleSignIn().signOut();

  if (googleUser == null) return; // المستخدم لغى العملية

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Sign in
  final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
  final user = userCredential.user;

  if (user != null) {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final docSnapshot = await userDoc.get();

    if (!docSnapshot.exists) {
      await userDoc.set({
        'name': user.displayName ?? 'Unknown',
        'email': user.email ?? '',
      });
    }
  }

  // انتقل لصفحة الدردشة
  Navigator.of(context)
      .pushNamedAndRemoveUntil(ChatPage.id, (route) => false);
}

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  GlobalKey<FormState> formstate = GlobalKey();
  bool isLoading = false;
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
                            "Welcome Back",
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
                            'Please Sign in to your account',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
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

                          // password textfield
                          GestureDetector(
                            onTap: () => showForgotPasswordDialog(context),
                            child: Container(
                              margin: EdgeInsets.only(top: 10.h, bottom: 20.h),
                              alignment: Alignment.topRight,
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.orange.shade200,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // login button
                    CustomButton(
                      title: 'Login with Email',
                      onPressed: () async {
                        if (!formstate.currentState!.validate()) return;

                        setState(() {
                          isLoading = true;
                        });

                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );

                          User? user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            await user.reload();
                            if (user.emailVerified) {
                            Navigator.pushReplacementNamed(context, ChatPage.id);
                            } else {
                              await user.sendEmailVerification();
                              showMessage(
                                context,
                                title: 'Email not verified',
                                message:
                                    'A verification link has been sent to your email. Please check your inbox and verify your email before logging in.',
                              );
                            }
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showMessage(
                              context,
                              title: 'User Not Found',
                              message: 'No user found for that email.',
                            );
                          } else if (e.code == 'wrong-password') {
                            showMessage(
                              context,
                              title: 'Wrong Password',
                              message: 'The password provided is incorrect.',
                            );
                          } else {
                            showMessage(
                              context,
                              title: 'Error',
                              message: e.message,
                            );
                          }
                        } catch (e) {
                          showMessage(
                            context,
                            title: 'Error',
                            message: e.toString(),
                          );
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    // Text('Or Continue with'),
                    MaterialButton(
                      height: 40.h,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      textColor: Colors.white,
                      color: Colors.red.shade700,
                      onPressed: () async {
                        await signInWithGoogle();
                        Navigator.pushReplacementNamed(context, ChatPage.id);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Continue with Google'),
                          SizedBox(width: 10.w),
                          Image.asset('assets/icons/google.png', height: 20.h),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    InkWell(
                      onTap: () => Navigator.pushNamed(context, SignUp.id),
                      child: Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
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


