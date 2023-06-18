import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/models/post_model.dart';

import 'message_bubble.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  Messages({this.post, this.appointmentModel, super.key});
  PostModel? post;
  AppointmentModel? appointmentModel;

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder(
          stream: post != null ? post!.getStreamChat() : appointmentModel!.getStreamChat(),
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
            final id = post != null ? post!.id : appointmentModel!.id;

            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) => MessageBubble(
                  chatDocs[index]['message'],
                  id == userId ? false : true,
                  ValueKey(chatDocs[index].id)),
            );
          },
        );
      
    
  }
}
