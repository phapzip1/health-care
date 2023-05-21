import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CommendCard extends StatelessWidget {
  final String reviewId;
  final String patient_name;
  final String url;

  const CommendCard(this.reviewId, this.patient_name, this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE0E0E0),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(12),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('review_doctor')
              .doc(reviewId)
              .collection('context')
              .snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData) return Container();

            final userDocs = snapshot.data!.docs;

            return ListView.builder(
                itemCount: userDocs.length,
                itemBuilder: (context, index) {
                  return Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 26.0,
                              backgroundImage:
                                  NetworkImage(url),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  patient_name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  userDocs[index]['createAt'],
                                  style:
                                      const TextStyle(color: Color(0xFF828282)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.yellowAccent,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(userDocs[index]['rating'].toString())
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(userDocs[index]['text'].toString())
                    ),
                  ]);
                });
          }),
    );
  }
}
