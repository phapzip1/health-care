import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientSection extends StatefulWidget {
  const PatientSection(this.changedPage, {super.key});

  final bool changedPage;

  @override
  State<PatientSection> createState() => _PatientSectionState();
}

class _PatientSectionState extends State<PatientSection> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AppointmentModel.getAppointment(patientId: user!.uid),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!futureSnapshot.hasData ||
              futureSnapshot.data == null ||
              futureSnapshot.data!.isEmpty) {
            return Container();
          }

          final scheduleDocs = futureSnapshot.data!;

          return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: scheduleDocs.length,
              itemBuilder: (ctx, index) => Container(
                    margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFC9C9C9),
                          blurRadius: 1,
                          spreadRadius: 1,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: InkWell(
                      // onTap: () => {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => ChatScreen(
                      //               scheduleDocs[index]['chatId'],
                      //               scheduleDocs[index]['name'],
                      //               scheduleDocs[index]['image_url'])))
                      // },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        scheduleDocs[index].doctorName,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        scheduleDocs[index].specialization,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF828282)),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 26.0,
                                  backgroundImage: NetworkImage(
                                      scheduleDocs[index].doctorImage),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      scheduleDocs[index]
                                          .dateTime
                                          .toString()
                                          .substring(0, 10),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
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
                                      scheduleDocs[index]
                                          .dateTime
                                          .toString()
                                          .substring(10, 16),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 4,
                                      backgroundColor:
                                          !scheduleDocs[index].status
                                              ? const Color(0xFFE2B93B)
                                              : const Color(0xFF27AE60),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      scheduleDocs[index].status
                                          ? "Confirmed"
                                          : 'Waiting',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            widget.changedPage
                                ? Column(
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFFE0E0E0),
                                          elevation: 0,
                                        ),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('patient')
                                              .doc(user!.uid)
                                              .collection('schedule')
                                              .doc(scheduleDocs[index].id)
                                              .delete();
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ));
        });
  }
}
