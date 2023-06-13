import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/models/doctor_model.dart';
// import 'package:health_care/models/patient_model.dart';
import 'package:health_care/screens/payment_screen.dart';
// import 'package:health_care/widgets/comment_card.dart';
import 'package:intl/intl.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorInforPage extends StatefulWidget {
  const DoctorInforPage(this.doctorId, {super.key});
  final String doctorId;

  @override
  State<DoctorInforPage> createState() => _DoctorInforPageState();
}

const List<String> time = [
  '9:00 AM',
  '9:00 AM',
  '10:00 AM',
  '10:45 AM',
  '11:00 AM',
  '11:45 AM'
];

final user = FirebaseAuth.instance.currentUser;

Widget upperPart(doctor) => Card(
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
              children: const [
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.solidStar,
                      color: Color(0xFF3A86FF),
                      size: 20,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    // ignore: prefer_const_constructors
                    Text(
                      '4.5',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(
                  width: 24,
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.solidMessage,
                      color: Color(0xFF3A86FF),
                      size: 20,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '4',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
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
                  doctor.price.toString(),
                  style: const TextStyle(
                      color: Color(0xFF3A86FF), fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Appointments',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF828282)),
                    ),
                    Text(
                      '22',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Consultations',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF828282)),
                    ),
                    Text(
                      '1',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.red),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

class _DoctorInforPageState extends State<DoctorInforPage> {
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Doctor Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: DoctorModel.getById(widget.doctorId),
              builder: (ctx, futureSnapShot) {
                if (futureSnapShot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!futureSnapShot.hasData) return Container();

                final userDocs = futureSnapShot.data!;

                final doctor = DoctorModel(
                    userDocs.id,
                    userDocs.name,
                    userDocs.phoneNumber,
                    userDocs.gender,
                    userDocs.birthdate,
                    userDocs.email,
                    userDocs.experience,
                    userDocs.price,
                    userDocs.workplace,
                    userDocs.specialization,
                    userDocs.identityId,
                    userDocs.licenseId,
                    userDocs.image,
                    userDocs.availableTime);

                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            upperPart(userDocs),
                            const SizedBox(
                              height: 8,
                            ),
                            Card(
                              child: Column(children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'About doctor',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Year of experience',
                                            style: TextStyle(),
                                          ),
                                          Text(
                                            '${userDocs.experience} years',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      // ignore: prefer_const_constructors
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            'Patients checked',
                                            style: TextStyle(),
                                          ),
                                          Text(
                                            '2',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const Text(
                                        'Schedules',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          _selectDate(context);
                                        },
                                        style: OutlinedButton.styleFrom(
                                          primary: Colors.black,
                                          textStyle:
                                              const TextStyle(fontSize: 16),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50)),
                                          ),
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(DateFormat('dd/MM/y')
                                                  .format(selectedDate)),
                                              const Icon(
                                                FontAwesomeIcons.calendar,
                                                color: Colors.black,
                                              ),
                                            ]),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      const Text(
                                        'Time available',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: mediaQuery.width * 0.12,
                                  child:
                                      // userDocs['availableTime'].
                                      ListView.builder(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 2),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: time.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  right: 8),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xFFC9C9C9),
                                                    blurRadius: 0.5,
                                                    spreadRadius: 0.5,
                                                  ),
                                                ],
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: Center(
                                                  child:
                                                      Text('${time[index]}')),
                                            );
                                          }),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                    ),
                                    onPressed: () {
                                      //payment screen
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentScreen(doctor)));
                                    },
                                    child: const Text(
                                      'Make appointment',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  // ignore: prefer_const_constructors
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Reviews',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        // StreamBuilder(
                                        //     stream: FirebaseFirestore.instance
                                        //         .collection('doctor')
                                        //         .doc(widget.doctorId)
                                        //         .collection('reviews')
                                        //         .snapshots(),
                                        //     builder: (ctx, snapshot) {
                                        //       if (snapshot.connectionState ==
                                        //           ConnectionState.waiting) {
                                        //         return const Center(
                                        //             child:
                                        //                 CircularProgressIndicator());
                                        //       }

                                        //       if (!snapshot.hasData ||
                                        //           snapshot.data == null ||
                                        //           snapshot.data!.docs.isEmpty) {
                                        //         return Container();
                                        //       }

                                        //       final comment =
                                        //           snapshot.data!.docs;

                                        //       return Container(
                                        //         width: double.infinity,
                                        //         height: mediaQuery.width * 0.5,
                                        //         child: ListView.builder(
                                        //             itemCount: comment.length,
                                        //             itemBuilder:
                                        //                 (context, index) {
                                        //               return CommendCard(
                                        //                   comment[index]
                                        //                       ['reviewId'],
                                        //                   comment[index]
                                        //                       ['patient_name'],
                                        //                   comment[index]
                                        //                       ['image_url']);
                                        //             }),
                                        //       );
                                        //     })
                                      ]),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}
