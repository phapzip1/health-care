import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/models/health_record_model.dart';
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
          child: FutureBuilder(
            future: HealthRecordModel.get(patientId: user!.uid),
            builder: (ctx, futureSnapshot) {
              if (futureSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final healthRecord = futureSnapshot.data!;
              
              return ListView.builder(
                itemCount: healthRecord.length,
                itemBuilder: (ctx, index) => RecordTag(
                  'abxc',
                  healthRecord[index].doctorName,
                  healthRecord[index].time,
                  'W.')
              );
            },
          ),
        ));
  }
}
