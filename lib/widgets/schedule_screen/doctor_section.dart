import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/widgets/card_appointment_doctor.dart';


class DoctorSection extends StatefulWidget {
  const DoctorSection(this.changedPage, {super.key});

  final bool changedPage;

  @override
  State<DoctorSection> createState() => _DoctorSectionState();
}

class _DoctorSectionState extends State<DoctorSection> {
  final user = FirebaseAuth.instance.currentUser;

  void _updateStatus(String id, int status) async {
    await FirebaseFirestore.instance
        .collection('appointment')
        .doc(id)
        .update({'status': status});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return FutureBuilder(
        future: !widget.changedPage
            ? AppointmentModel.getAppointmentHistory(doctorId: user!.uid)
            : AppointmentModel.getAppointment(doctorId: user!.uid),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final scheduleDocs = futureSnapshot.data!;

          return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: scheduleDocs.length,
              itemBuilder: (ctx, index) {
                String time = scheduleDocs[index].meetingTime % 10 == 3
                    ? '${scheduleDocs[index].meetingTime ~/ 10}:30'
                    : '${scheduleDocs[index].meetingTime ~/ 10}:00';
                return CardAppointmentDoctor(widget.changedPage, mediaQuery,
                    scheduleDocs[index], time, _updateStatus);
              });
        });
  }
}
