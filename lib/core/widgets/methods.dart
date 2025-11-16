import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Methods {
  static void showMesseage(BuildContext context, String measseg) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(measseg),
        ),
      );
    }
  }

 static Future<void> registerNewUser(String email, String password) async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
  }
}