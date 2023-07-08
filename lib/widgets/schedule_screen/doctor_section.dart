import 'package:flutter/material.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/widgets/card_appointment_doctor.dart';
import 'package:health_care/widgets/schedule_screen/header.dart';

class DoctorSection extends StatefulWidget {
  const DoctorSection(this.scheduleDocs, {super.key});

  final List<AppointmentModel> scheduleDocs;

  @override
  State<DoctorSection> createState() => _DoctorSectionState();
}

class _DoctorSectionState extends State<DoctorSection> {
  bool _changedPage = true;

  void _updateStatus(String id, int status) async {
    await FirebaseFirestore.instance
        .collection('appointment')
        .doc(id)
        .update({'status': status});
  }

  void _click(value) {
    setState(() {
      _changedPage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    var filterList;
    final now = DateTime.now();
    if (_changedPage) {
      filterList = widget.scheduleDocs
          .where((element) =>
              element.datetime.isBefore(now) && element.status <= 1)
          .toList();
    } else {
      filterList = widget.scheduleDocs
          .where(
              (element) => element.datetime.isAfter(now) || element.status > 1)
          .toList();
    }

    return Column(
      children: [
        Header(_click, _changedPage),
        Expanded(
          child: filterList.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: Image(image: AssetImage('assets/images/waiting.png')))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filterList.length,
                  itemBuilder: (ctx, index) {
                    String time = filterList[index].datetime.hour % 10 == 3
                        ? '${filterList[index].datetime.hour ~/ 10}:30'
                        : '${filterList[index].datetime.hour ~/ 10}:00';
                    return CardAppointmentDoctor(_changedPage, mediaQuery,
                        filterList[index], time, _updateStatus);
                  }),
        ),
      ],
    );
  }
}
