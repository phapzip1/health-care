import '../../models/appointment_doctor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppointmentListDoctor extends StatelessWidget {
  final List<DoctorAppointment> appointmentList;

  const AppointmentListDoctor({super.key, required this.appointmentList});

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context).size;

    return Column(
      children: appointmentList
          .map(
            (e) => Container(
              margin: const EdgeInsets.only(top: 16.0),
              // ignore: sort_child_properties_last
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 28.0,
                            backgroundImage:
                                AssetImage('assets/images/avatartUser.jpg'),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.patient.patientName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(FontAwesomeIcons.calendar, size: 20,),
                                        const SizedBox(width: 4,),
                                        Text(
                                          e.day,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(FontAwesomeIcons.clock, size: 20,),
                                        const SizedBox(width: 4,),
                                        Text(
                                          e.time,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Issues:',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 4,),
                          Text(
                            e.issues,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFE0E0E0),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
            ),
          )
          .toList(),
    );
  }
}
