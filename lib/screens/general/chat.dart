import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/services/navigation_service.dart';

import '../../widgets/chat/messages.dart';
import '../../widgets/chat/new_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(this.appointment, {super.key});
  final AppointmentModel appointment;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final user = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final isDoctor = user == widget.appointment.doctorId;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(!isDoctor
                  ? widget.appointment.doctorImage
                  : widget.appointment.patientImage),
            ),
            const SizedBox(
              width: 4,
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  !isDoctor
                      ? widget.appointment.doctorName
                      : widget.appointment.patientName,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        actions: [
          isDoctor ? IconButton(
            onPressed: () {
              widget.appointment.makeCall().then((value) => NavigationService
                      .navKey.currentState!
                      .pushNamed("/call", arguments: {
                    'token': value,
                    'channel_id': widget.appointment.id,
                    'remote_name': widget.appointment.patientName,
                    'remote_cover': widget.appointment.patientImage,
                    'caller': true,
                  }));
            },
            icon: const Icon(Icons.videocam),
            color: Colors.black,
          ): Container()
        ],
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Container(
        child: Column(children: [
          Expanded(
            child: Messages(appointmentModel: widget.appointment),
          ),
          NewMessage(
            appointmentModel: widget.appointment,
          ),
        ]),
      ),
    );
  }
}
