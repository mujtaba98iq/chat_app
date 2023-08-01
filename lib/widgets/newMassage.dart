import 'package:chat_app/widgets/colors_and_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMassage extends StatelessWidget {
  const NewMassage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController massageController = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            autocorrect: true,
            enableSuggestions: true,
            textCapitalization: TextCapitalization.sentences,
            onSaved: (val) {},
            controller: massageController,
            decoration: InputDecoration(
              hintText: "Send Massage",
              fillColor: g1,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            if (massageController.text.isEmpty) {
              null;
            } else {
              final userId = FirebaseAuth.instance.currentUser!.uid;
              final userData = await FirebaseFirestore.instance
                  .collection("users")
                  .doc(userId)
                  .get();
              FocusScope.of(context).unfocus();
              FirebaseFirestore.instance.collection("chat").add({
                "text": massageController.text,
                "creatAt": Timestamp.now(),
                "username": userData['username'],
                "userId": userId,
                "userImage": userData['imageUrl']
              });
              massageController.clear();
            }
          },
          icon: const Icon(Icons.send),
          color: kButtonColor,
        ),
      ],
    );
  }
}
