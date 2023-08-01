import 'package:chat_app/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/colors_and_icons.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});
 var fbn=FirebaseMessaging.instance;
 
 @override
 void initState(){
   fbn.getToken().then((token) {
     print("========================================");
     print(token);
     print("========================================");
   });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
        backgroundColor: kButtonColor,
        actions: [
          CupertinoButton(
              child: const Icon(
                Icons.exit_to_app,
                color: g2,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Login()));
              })
        ],
      ),
      body: const Center(child: Text("Welcome")),
    );
  }
}
