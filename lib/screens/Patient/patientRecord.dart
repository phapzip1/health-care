import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PatientRecords extends StatefulWidget {
  const PatientRecords({super.key});

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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
          future: Future.value(user),
          builder: (ctx, futureSnapShot) {
            if (futureSnapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return StreamBuilder(
                // stream: ,
                builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData) return Container();

              // final userDocs = snapshot.data!;
              
              return Container();
            });
          },
        ),
      ),
    );
  }
}
