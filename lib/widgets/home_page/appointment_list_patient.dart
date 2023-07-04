import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/screens/Doctor/doctor_infor_page.dart';

class AppointmentListPatient extends StatelessWidget {
  AppointmentListPatient({required this.spec});

  final String spec;
  final _ref = FirebaseFirestore.instance.collection('doctor');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: spec != "All"
            ? _ref.where("specialization", isEqualTo: spec).get()
            : _ref.get(),
        builder: (ctx, futureSnapShot) {
          if (futureSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final doctorList = futureSnapShot.data!.docs;
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: doctorList.length,
              itemBuilder: (ctx, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 16),
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
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const DoctorInforPage(false)))
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image(
                                image: NetworkImage(
                                    doctorList[index].data()['image']),
                                height: 80,
                                width: 64,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doctorList[index].data()['name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    doctorList[index].data()['specialization'],
                                    style: const TextStyle(
                                        fontSize: 16, color: Color(0xFF828282)),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.solidStar,
                                            color: Colors.yellow,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          FutureBuilder(
                                              future:
                                                  ReviewModel.getAverageRating(
                                                      doctorList[index].id),
                                              builder: (ctx, rating) {
                                                if (rating.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const CircularProgressIndicator();
                                                }
                                                return Text(
                                                    rating.data.toString());
                                              }),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Consultation price:',
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFF828282)),
                            ),
                            Text("${doctorList[index].data()['price']} vnd",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ]),
                    ),
                  ),
                );
              });
        });
  }
}
