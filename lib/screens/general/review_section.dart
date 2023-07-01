import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ReviewSection extends StatelessWidget {
  final DoctorModel userDocs;
  ReviewSection(this.userDocs, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.value(FirebaseFirestore.instance
            .collection("review")
            .where('doctor_id', isEqualTo: userDocs.id)
            .get()),
        builder: (ctx, reviewSnapshot) {
          if (reviewSnapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (!reviewSnapshot.hasData) {
            return Container();
          }

          final reviews = reviewSnapshot.data!.docs;

          return ListView.builder(
              shrinkWrap: true,
              itemCount: reviews.length,
              itemBuilder: (ctx, index) {
                Timestamp timeStamp = reviews[index].data()['create_at'];
                double rating = reviews[index].data()['rating'];
                return Container(
                  padding: const EdgeInsets.all(16),
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 26.0,
                                backgroundImage: NetworkImage(
                                    reviews[index].data()['patient_image'])),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    reviews[index].data()['patient_name'] +
                                        reviews[index].data()['patient_name'] +
                                        reviews[index].data()['patient_name'] +
                                        reviews[index].data()['patient_name'] +
                                        reviews[index].data()['patient_name'],
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                Text(
                                  DateFormat('dd/MM/y')
                                      .format(timeStamp.toDate()),
                                  style: const TextStyle(
                                      color: Color(0xFF666666), fontSize: 16),
                                )
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Colors.yellow,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  rating.round().toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          reviews[index].data()['feedback'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ]),
                );
              });
        });
  }
}
