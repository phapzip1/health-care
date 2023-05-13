

import 'package:flutter/material.dart';
import 'package:health_care/widgets/schedule_screen/header.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_care/widgets/schedule_screen/patient_section.dart';

class PatientSchedulePage extends StatefulWidget {
  const PatientSchedulePage({super.key});

  @override
  State<PatientSchedulePage> createState() => _PatientSchedulePageState();
}

class _PatientSchedulePageState extends State<PatientSchedulePage> {
  final user = FirebaseAuth.instance.currentUser;

  bool _changedPage = true;

  void _click(value) {
    setState(() {
      _changedPage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Header(_click, _changedPage),

          Expanded(
            child: PatientSection(_changedPage),
          ),
        ],
      ),
    );
  }
}
