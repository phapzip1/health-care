import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:intl/intl.dart';

class AppointmentListDoctor extends StatelessWidget {
  final String doctorId;
  const AppointmentListDoctor(this.doctorId, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AppointmentModel.getAppointment(doctorId: doctorId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final doctor = snapshot.data!;

          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: doctor.length,
              itemBuilder: (ctx, index) {
                String time = doctor[index].meetingTime % 10 == 3
                    ? '${doctor[index].meetingTime ~/ 10}:30'
                    : '${doctor[index].meetingTime ~/ 10}:00';
                return Container(
                  margin:
                      const EdgeInsets.only(top: 16.0, right: 16.0, left: 16),
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFC9C9C9),
                          blurRadius: 1,
                          spreadRadius: 0.8,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  // ignore: sort_child_properties_last
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 28.0,
                              backgroundImage:
                                  NetworkImage(doctor[index].patientImage),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doctor[index].patientName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.calendar,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            DateFormat('dd-MM-y').format(doctor[index].dateTime),
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 32,),
                                      Row(
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.clock,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            time,
                                            style:
                                                const TextStyle(fontSize: 16),
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
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              doctor[index].specialization,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
