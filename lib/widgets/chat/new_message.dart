// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/models/post_model.dart';

class NewMessage extends StatefulWidget {
  NewMessage({this.post, this.appointmentModel, super.key});
  final PostModel? post;
  final AppointmentModel? appointmentModel;

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _enterMessage = '';

  final _controller = TextEditingController();

  var object;

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;

    await object.reply(_enterMessage, user!.uid);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    object = widget.post ?? widget.appointmentModel;
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFFC9C9C9),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '...',
              ),
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  _enterMessage = value.toString();
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enterMessage.trim().isEmpty ? null : _sendMessage,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}