import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health_care/models/doctor_info.dart';
import 'package:health_care/models/reivew.dart';
import 'package:health_care/widgets/card_appointment_patient.dart';
import 'package:intl/intl.dart';
import '../../models/appointment_patient.dart';
import 'package:health_care/widgets/button_section.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _changedPage = true;

  void _click(value) {
    setState(() {
      _changedPage = value;
    });
  }

  final String formattedTime = DateFormat.jm().format(DateTime.now());
  final String formattedDate = DateFormat.yMd().format(DateTime.now());

  final Doctor doctor =
      Doctor('123', 'Dr. Chris Frazier', 'Pediatrician', 4.5, 20, 198, [
    new DateTime(2023, 6, 25, 9, 30),
    new DateTime(2023, 6, 15, 8, 30)
  ], [
    Review(
        name: 'khanh',
        timePosted: new DateTime(2023, 6, 25, 9, 30),
        rating: 4.5,
        context: 'a')
  ]);

  @override
  Widget build(BuildContext context) {
    final List<PatientAppointment> appointmentList = [
      PatientAppointment(formattedTime, doctor, 1, formattedDate),
      PatientAppointment(formattedTime, doctor, 2, formattedDate),
      PatientAppointment(formattedTime, doctor, 0, formattedDate),
      PatientAppointment(formattedTime, doctor, 1, formattedDate),
    ];

    final List<PatientAppointment> lastAppointment = [
      PatientAppointment(formattedTime, doctor, 1, formattedDate),
    ];

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Schedule',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                ButtonSection(
                  click: _click,
                  status: _changedPage,
                  mediaQuery: MediaQuery.of(context),
                  sampleData: [
                    RadioModel(true, "Upcoming", 0),
                    RadioModel(false, "History", 1)
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),

                Text(
                  _changedPage ? 'Nearest visit' : 'Last visit',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          _changedPage ? Expanded(
            child: ListCardScheduleForPatient(appointmentList: appointmentList),
          ): Container(),
          
        ],
      ),
    );
  }
}
