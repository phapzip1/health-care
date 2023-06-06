import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/models/post_model.dart';

import 'message_bubble.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  Messages(this.post, {super.key});
  PostModel post;

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder(
          stream: post.getStreamChat(),
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
                  chatDocs[index]['message'],
                  post.id == userId ? false : true,
                  ValueKey(chatDocs[index].id)),
            );
          },
        );
      
    
  }
}
