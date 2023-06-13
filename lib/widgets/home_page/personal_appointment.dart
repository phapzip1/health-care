import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/models/appointment_model.dart';

class PersonalAppointment extends StatefulWidget {
  const PersonalAppointment({super.key});

  @override
  State<PersonalAppointment> createState() => _PersonalAppointmentState();
}

class _PersonalAppointmentState extends State<PersonalAppointment> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AppointmentModel.getAppointment(patientId: user!.uid),
        builder: (ctx, futureSnapShot) {
          if (futureSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          ///here
          if (!futureSnapShot.hasData || futureSnapShot.data == null) {
            return Container();
          }
          final appointmentDocs = futureSnapShot.data!;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: appointmentDocs.length,
            itemBuilder: (ctx, index) => Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFC9C9C9),
                    blurRadius: 1,
                    spreadRadius: 1,
                  ),
                ],
                color: Color(0xFFAEE6FF),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              // ignore: sort_child_properties_last
              child: IntrinsicWidth(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 28.0,
                            backgroundImage: NetworkImage(
                                appointmentDocs[index].doctorImage),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appointmentDocs[index].doctorName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                appointmentDocs[index].specialization,
                                style: const TextStyle(
                                    color: Color(0xFF828282), fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.clock,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(appointmentDocs[index].dateTime.toString().substring(0, 10)),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(appointmentDocs[index].dateTime.toString().substring(10, 16))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
