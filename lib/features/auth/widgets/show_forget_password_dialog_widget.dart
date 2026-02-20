import 'package:chat_app/core/widgets/spacing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showForgotPasswordDialog(BuildContext context) {
  TextEditingController emailController = TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // icon
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.orange.withOpacity(0.15),
                child: Icon(
                  Icons.lock_reset,
                  color: Colors.orange,
                  size: 30,
                ),
              ),

              SizedBox(height: 15.h),

              Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Enter your email to receive a password reset link',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              // email field
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email, color: Colors.orange),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // send button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 14.r),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    final email = emailController.text.trim();
                    if (email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter your email')),
                      );
                      return;
                    }

                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                        email: email,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Password reset link has been sent to $email',
                          ),
                        ),
                      );
                      Navigator.pop(context); 
                    } on FirebaseAuthException catch (e) {
                      String message = 'An error occurred';
                      if (e.code == 'user-not-found') {
                        message = 'No user found for this email';
                      } else if (e.code == 'invalid-email') {
                        message = 'The email address is not valid';
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Something went wrong')),
                      );
                    }
                  },
                  child: Text(
                    'Send Reset Link',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              HeightSpace(20),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
