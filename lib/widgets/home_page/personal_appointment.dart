import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


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
        future: Future.value(user),
        builder: (ctx, futureSnapShot) {
          if (futureSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('patient')
                  .doc(user!.uid)
                  .collection('schedule')
                  .snapshots(),
              builder: (ctx, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                ///here
                if (!snapShot.hasData || snapShot.data == null) {
                  return Container();
                }
                final appointmentDocs = snapShot.data!.docs;

                return ListView.builder(
                  itemCount: appointmentDocs.length,
                  itemBuilder: (ctx, index) => Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                
                    // ignore: sort_child_properties_last
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: const Color(0xFFAEE6FF),
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
                                      NetworkImage(appointmentDocs[index]['image_url']),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appointmentDocs[index]['doctor_name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      appointmentDocs[index]['specialization'],
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
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
                                    Text(appointmentDocs[index]['time_meeting']),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(appointmentDocs[index]['date'])
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFE0E0E9),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
