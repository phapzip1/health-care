// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:health_care/models/symptom.dart';
import 'package:health_care/widgets/home_page/appointment_list_patient.dart';

class TypicalDoctor extends StatefulWidget {
  List<Symptom> symptoms;
  TypicalDoctor(this.symptoms, {super.key});

  @override
  State<TypicalDoctor> createState() => _TypicalDoctorState();
}

class _TypicalDoctorState extends State<TypicalDoctor> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(bottom: 4),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.symptoms.length,
              itemBuilder: (ctx2, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: IntrinsicHeight(
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFC9C9C9),
                              blurRadius: 1,
                              spreadRadius: 1,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                widget.symptoms[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Image.network(
                                widget.symptoms[index].icon,
                                frameBuilder: (context, child, frame,
                                    wasSynchronouslyLoaded) {
                                  if (wasSynchronouslyLoaded) {
                                    return child;
                                  }
                                  return Image.asset(
                                      "assets/images/fallback.jpg");
                                },
                                width: 24,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (widget.symptoms.isNotEmpty)
            AppointmentListPatient(spec: widget.symptoms[_selectedIndex].name),
        ],
      ),
    );
  }
}
