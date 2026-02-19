import 'package:chat_app/core/services/firebase/auth/auth_services.dart';
import 'package:chat_app/features/auth/sign_in.dart';
import 'package:chat_app/features/auth/sign_up.dart';
import 'package:chat_app/features/chat/chat_page.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Chatna());
  AuthServices().cheackIfUserIsSignedInOrNot();
}

class Chatna extends StatelessWidget {
  const Chatna({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp(
          routes: {
            SignIn.id: (context) => SignIn(),
            SignUp.id: (context) => SignUp(),
            ChatPage.id: (context) => ChatPage(),
          },
          debugShowCheckedModeBanner: false,
          title: 'Chatna',
          initialRoute: AuthServices.isSignedIn ? ChatPage.id : SignIn.id,
        );
      },
    );
  }
}
