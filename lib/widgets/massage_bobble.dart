import 'package:chat_app/screens/login.dart';
import 'package:chat_app/widgets/colors_and_icons.dart';
import 'package:flutter/material.dart';

class MassageBobble extends StatelessWidget {
  const MassageBobble(
    this.massage,
    this.userName,
    this.isMe,
    this.userImage, {
    required this.key,
  });

  final Key key;
  final String massage, userName;
  final bool isMe;
  final userImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: !isMe ? Colors.grey[300] : g2,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(14),
                    topRight: const Radius.circular(14),
                    bottomLeft: !isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(14),
                    bottomRight: isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(14)),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                        color: isMe ? Colors.black : Colors.grey[900],
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    massage,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.grey[800],
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0, 
          left: !isMe ? 120 : null,
          right: isMe?120:null,        
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(userImage),
        ))
      ],
    );
  }
}
