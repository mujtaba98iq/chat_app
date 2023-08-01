import 'package:chat_app/widgets/massage_bobble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Massage extends StatelessWidget {
  const Massage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .orderBy("creatAt", descending: true)
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final docs = snapshot.data?.docs;
          return ListView.builder(
              reverse: true,
              itemCount: docs?.length,
              itemBuilder: (ctx, index) => MassageBobble(
                  docs![index]['text'],
                  docs[index]['username'],
                  docs[index]['userId'] == userId ,
                  docs[index]['userImage'],
                  key: ValueKey(docs[index].id)));
        },
      ),
    );
  }
}
