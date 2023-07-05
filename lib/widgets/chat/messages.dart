import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/models/post_model.dart';

import 'message_bubble.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Messages extends StatelessWidget {
  Messages({super.key, required this.post});
  PostModel post;

  @override
  Widget build(BuildContext context) {
    final id = context.read<AppBloc>().state.user!.uid;
    return StreamBuilder(
      stream: context.read<AppBloc>().postProvider.getStreamChat(post.id),
      builder: (ctx, chatSnapShot) {
        if (chatSnapShot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        ///here
        if (!chatSnapShot.hasData || chatSnapShot.data == null || chatSnapShot.data!.docs.isEmpty) {
          return Container();
        }

        final chatDocs = chatSnapShot.data!.docs;

        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => MessageBubble(chatDocs[index]['message'], chatDocs[index]['sender_id'] == id, ValueKey(chatDocs[index].id)),
        );
      },
    );
  }
}
