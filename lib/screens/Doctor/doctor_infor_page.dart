import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/models/doctor_model.dart';
// import 'package:health_care/screens/doctor_schedule_screen.dart';
// import 'package:health_care/models/patient_model.dart';
// import 'package:health_care/screens/payment_screen.dart';
import 'package:health_care/services/navigation_service.dart';
// import 'package:health_care/widgets/comment_card.dart';
import 'package:intl/intl.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorInforPage extends StatefulWidget {
  const DoctorInforPage(this.doctorId, this.isDoctor, {super.key});
  final String doctorId;
  final bool isDoctor;

  @override
  State<DoctorInforPage> createState() => _DoctorInforPageState();
}

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
  DateTime _selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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

                if (!futureSnapShot.hasData) {
                  return Container();
                }

                final userDocs = futureSnapShot.data!;

                // final doctor = DoctorModel(
                //     userDocs.id,
                //     userDocs.name,
                //     userDocs.phoneNumber,
                //     userDocs.gender,
                //     userDocs.birthdate,
                //     userDocs.email,
                //     userDocs.experience,
                //     userDocs.price,
                //     userDocs.workplace,
                //     userDocs.specialization,
                //     userDocs.identityId,
                //     userDocs.licenseId,
                //     userDocs.image);

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
                                                  .format(_selectedDate)),
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
                                FutureBuilder(
                                    future: userDocs.checkTime(),
                                    builder: (ctx, futureCheck) {
                                      if (futureCheck.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (futureCheck.data!) {
                                        return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                          ),
                                          onPressed: () {
                                            NavigationService
                                                .navKey.currentState
                                                ?.pushNamed('/schedule',
                                                    arguments: userDocs.id);
                                          },
                                          child: const Text(
                                            'Choose your time for consultant',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        );
                                      }
                                      // return ListView.builder(
                                      //   itemCount: ,
                                      //   itemBuilder:
                                      // );
                                      return Container();
                                    }),
                                const SizedBox(
                                  height: 16,
                                ),
                                !widget.isDoctor
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                        ),
                                        onPressed: () {
                                          //payment screen
                                          NavigationService.navKey.currentState
                                              ?.pushNamed('/payment',
                                                  arguments: {
                                                'doctorId': userDocs.id,
                                                'doctorName': userDocs.name,
                                                'price': userDocs.price,
                                                'doctorPhone': userDocs.phoneNumber,
                                                'doctorImage': userDocs.image,
                                                'doctorSpecialization': userDocs.specialization,
                                                'date': _selectedDate,
                                                'hour': 8
                                              });
                                        },
                                        child: const Text(
                                          'Make appointment',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ))
                                    : Container(),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  // ignore: prefer_const_constructors
                                  child: const Column(children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Reviews',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
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
