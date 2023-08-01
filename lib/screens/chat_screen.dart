import 'package:chat_app/widgets/colors_and_icons.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/massage.dart';
import 'package:chat_app/widgets/newMassage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState (){
    super.initState();
    final fbn =FirebaseMessaging;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watsapp "),
        backgroundColor: g2,
        actions: [
          InkWell(
            onTap: (){
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const Login()));
            },
            child: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  const [
          Expanded(
            child: Massage(),
          ),
          NewMassage(),

        ],
      ),
    );
  }
}
