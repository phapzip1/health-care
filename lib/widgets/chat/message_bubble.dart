import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
    this.message,
    this.isDoctor,
    this.key,
  );

  final String message;
  final bool isDoctor;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isDoctor ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: !isDoctor ? Colors.grey : const Color(0xFF3A86FF),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: !isDoctor
                    ? const Radius.circular(0)
                    : const Radius.circular(12),
                bottomRight: isDoctor
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
                    isDoctor ? Alignment.centerRight : Alignment.centerLeft,
                child: Text(
                  message,
                  style:
                      TextStyle(color: !isDoctor ? Colors.black : Colors.white),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ]);
  }
}
