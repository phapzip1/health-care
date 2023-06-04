import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
    this.message,
    this.userName,
    this.userImage,
    this.isMe,
    this.key,
  );

  final String message;
  final bool isMe;
  final String userName;
  final String userImage;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              backgroundImage: NetworkImage(userImage),
            ),
          Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.grey : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: !isMe ? const Radius.circular(0) : const Radius.circular(12),
                bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(12),
              ),
            ),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMe)
                  Text(
                    userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe ? Colors.black : Colors.white),
                  ),
                Text(
                  message,
                  style: TextStyle(color: isMe ? Colors.black : Colors.white),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ]);
  }
}
