import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
    this.message,
    this.isMe,
    this.key,
  );

  final String message;
  final bool isMe;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: !isMe ? Colors.grey : const Color(0xFF3A86FF),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: !isMe
                    ? const Radius.circular(0)
                    : const Radius.circular(12),
                bottomRight: isMe
                    ? const Radius.circular(0)
                    : const Radius.circular(12),
              ),
            ),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: IntrinsicWidth(
              child: Align(
                alignment:
                    isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Text(
                  message,
                  style:
                      TextStyle(color: !isMe ? Colors.black : Colors.white),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ]);
  }
}