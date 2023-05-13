// import './widgets/chat/message_bubble.dart';
import 'message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  Messages(this.chatId, this.username, this.userImage, {super.key});
  final String chatId;
  final String username;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, futureSnapShot) {
        if (futureSnapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .doc(chatId)
              .collection('context')
              .snapshots(),
          builder: (ctx, chatSnapShot) {
            if (chatSnapShot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            ///here
            if (!chatSnapShot.hasData ||
                chatSnapShot.data == null ||
                chatSnapShot.data!.docs.isEmpty) {
              return Container();
            }

            final chatDocs = chatSnapShot.data!.docs;
            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) => MessageBubble(
                  chatDocs[index]['text'],
                  username,
                  userImage,
                  chatDocs[index]['senderId'] == futureSnapShot.data!.uid,
                  ValueKey(chatDocs[index].id)),
            );
          },
        );
      },
    );
  }
}
