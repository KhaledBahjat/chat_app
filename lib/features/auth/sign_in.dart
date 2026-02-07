import 'package:chat_app/core/theme/app_color.dart';
import 'package:chat_app/core/widgets/spacing.dart';
import 'package:chat_app/features/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          children: [
            HeightSpace(50),
            Image.asset('assets/image/logo.png', height: 150, width: 200),
            Text(
              'Chatna',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontFamily: 'Pacifico',
              ),
            ),
            Text(
              'LOG IN',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'Pacifico',
              ),
            ),
            TextFieldWidget(
              validator: (value) {},
              hintText: "Email",
              suffixIcon: Icon(Icons.email, color: Colors.black),
            ),
            HeightSpace(20),
            TextFieldWidget(
              validator: (value) {},
              hintText: "Password",
              obscureText: obscureText,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: obscureText
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
