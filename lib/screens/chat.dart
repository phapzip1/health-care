import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen(this.chatId, this.username, this.userImage, {super.key});
  final String chatId;
  final String username;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Chat App'),
      ),
      body: Container(
        child: Column(children: [
          Expanded(
            child: Messages(chatId, username, userImage),
          ),
          NewMessage(chatId),
        ]),
      ),
    );
  }
}
