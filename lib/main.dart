
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var fbn=FirebaseMessaging.instance;
  fbn.getToken().then((token) {
    print("========================================");
    print(token);
    print("========================================");
  });
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      isLogin = false;
    } else {
      isLogin = true;
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          canvasColor: Colors.white,
            fontFamily: "SF-pro-Text",
            primarySwatch: Colors.pink,
            backgroundColor: Colors.orange,
            accentColor: Colors.deepPurple,
            accentColorBrightness: Brightness.dark),
        home:
         isLogin == true ? const ChatScreen() : const Login(),
        );
  }
}
