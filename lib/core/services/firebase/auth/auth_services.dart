import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  // check if user is signed in or not
  FirebaseAuth auth = FirebaseAuth.instance;
 static bool isSignedIn = false;

  void cheackIfUserIsSignedInOrNot() =>
      auth.authStateChanges().listen((User? user) {
        if (user == null) {
          log('User is currently signed out!');
        } else {
          isSignedIn = true;
          log('User is signed in!');
        }
      });



}
