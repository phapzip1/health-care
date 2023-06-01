import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/models/patient_model.dart';
import 'package:health_care/screens/Patient/updatePatientInformation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class PatientInformation extends StatefulWidget {
  const PatientInformation(this.id, {super.key});
  final String id;

  @override
  State<PatientInformation> createState() => _PatientInformationState();
}

class _PatientInformationState extends State<PatientInformation> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAEE6FF),
      body: SafeArea(
          child: FutureBuilder(
              future: PatientModel.getById(user!.uid),
              builder: (ctx, futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(FontAwesomeIcons.gear)),
                    ),
                    Center(
                      child: Stack(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                        ),
                        Container(
                          height: 410,
                          child: Card(
                            margin: const EdgeInsets.only(top: 48),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 16, left: 16, bottom: 16),
                              child: Container(
                                margin: const EdgeInsets.only(top: 60),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            futureSnapshot.data!.name,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                minimumSize: const Size(30, 30),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const UpdatePatientInfo()));
                                              },
                                              child: const ImageIcon(
                                                AssetImage(
                                                    "assets/images/edit.png"),
                                                color: Color(0xFF3A86FF),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text(
                                        'Basic information',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.phone_rounded),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Text('Phone Number:',
                                              style: TextStyle(fontSize: 16)),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(futureSnapshot.data!.phoneNumber,
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          const ImageIcon(AssetImage(
                                              "assets/images/gender.png")),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Text('Gender:',
                                              style: TextStyle(fontSize: 16)),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                              futureSnapshot.data!.gender
                                                  .toString().substring(7),
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          const ImageIcon(AssetImage(
                                              "assets/images/birthday.png")),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Text('Birthday:',
                                              style: TextStyle(fontSize: 16)),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                              DateFormat('dd/MM/y').format(
                                                  futureSnapshot
                                                      .data!.birthdate),
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      const Text(
                                        "Contact",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          const ImageIcon(AssetImage(
                                              "assets/images/email.png")),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Text('Email:',
                                              style: TextStyle(fontSize: 16)),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(futureSnapshot.data!.email,
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ],
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 5,
                            left: 0,
                            right: 0,
                            child: SizedBox(
                              child: CircleAvatar(
                                radius: 56.0,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 48.0,
                                  backgroundImage:
                                      NetworkImage(futureSnapshot.data!.image),
                                ),
                              ),
                            )),
                      ]),
                    ),
                  ],
                );
              })),
    );
  }
}
