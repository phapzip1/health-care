import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpperPart extends StatelessWidget {
  final DoctorModel doctor;
  UpperPart(this.doctor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 56.0,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 48.0,
                backgroundImage: NetworkImage(doctor.image),
              ),
            ),
            Text(
              doctor.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            // ignore: prefer_const_constructors
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.solidStar,
                      color: Color(0xFF3A86FF),
                      size: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    // ignore: prefer_const_constructors
                    Text(
                      '${doctor.rating}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    )
                  ],
                ),
                const SizedBox(
                  width: 24,
                ),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.solidMessage,
                      color: Color(0xFF3A86FF),
                      size: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("review")
                            .where("doctor_id", isEqualTo: doctor.id)
                            .get(),
                        builder: (ctx, review) {
                          if (review.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          return Text(
                            '${review.hasData ? review.data!.size : 0}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          );
                        }),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              doctor.workplace,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF828282)),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: const Color(0xFFAEE6FF).withOpacity(0.5),
              ),
              child: Text(
                doctor.specialization,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: Color(0xFF3A86FF)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Consultation price: ',
                  style: TextStyle(
                    color: Color(0xFF828282),
                  ),
                ),
                Text(
                  "${(doctor.price as double).truncate()} vnd",
                  style: const TextStyle(
                      color: Color(0xFF3A86FF), fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
