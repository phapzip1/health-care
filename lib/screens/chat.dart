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
        titleSpacing: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(userImage),
            ),
            const SizedBox(
              width: 4,
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  username,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        ///////// here
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.phone),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera),
            color: Colors.black,
          ),
        ],
        leading: const BackButton(
          color: Colors.black,
        ),
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
