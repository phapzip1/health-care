import 'package:flutter/material.dart';
import 'package:health_care/widgets/schedule_screen/doctor_section.dart';
import 'package:health_care/widgets/schedule_screen/header.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DoctorSchedulePage extends StatefulWidget {
  const DoctorSchedulePage({super.key});

  @override
  State<DoctorSchedulePage> createState() => _DoctorSchedulePageState();
}

class _DoctorSchedulePageState extends State<DoctorSchedulePage> {
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
            child: DoctorSection(_changedPage),
          ),
        ],
      ),
    );
  }
}
