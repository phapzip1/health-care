import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/widgets/record_screen/record_tag.dart';

class PatientRecords extends StatefulWidget {
  final String id;
  const PatientRecords(this.id, {super.key});

  @override
  State<PatientRecords> createState() => _PatientRecordsState();
}

class _PatientRecordsState extends State<PatientRecords> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Records',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const RecordTag(
              'abxc',
              'Nguyen Huynh Tuan Khang',
              '2023-04-19 08:00AM',
              'https://firebasestorage.googleapis.com/v0/b/health-meeting.appspot.com/o/user_image%2Fk4dlvEnUVZRQsALVJ3c66gc4FjW2.jpeg?alt=media&token=d44ab499-2fa1-474c-b1fd-3d9e195f70b4&_gl=1*idz8bx*_ga*MTgzNjc1MDcxOS4xNjgyNzM4NTY0*_ga_CW55HF8NVT*MTY4NTUwNDQ5MS40My4xLjE2ODU1MDU2MTIuMC4wLjA.')),
    );
  }
}
