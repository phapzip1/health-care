import 'package:flutter/material.dart';
import 'package:health_care/models/symptom.dart';
import 'package:health_care/widgets/function_category.dart';
import 'package:health_care/widgets/home_page/personal_appointment.dart';
import '../../widgets/home_page/appointment_list_patient.dart';
import 'package:health_care/widgets/header_section.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  final List<Symptom> symptoms = [
    Symptom('Bone', 'assets/images/bone.png'),
    Symptom('Joint', 'assets/images/joint.png'),
    Symptom('Digest', 'assets/images/stomachache.png'),
    Symptom('Nerve', 'assets/images/brain.png'),
  ];

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SingleChildScrollView(
            child: FutureBuilder(
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
                        .snapshots(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData) return Container();

                      final userDocs = snapshot.data!;

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderSection(
                                    url: userDocs['image_url'],
                                    userName: userDocs['patient_name']),
                                // Search(_searchController),
                                const FunctionCategory(),
                                const Text(
                                  'My Appointment',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      height: 1.1),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  child: const SizedBox(
                                    width: double.infinity,
                                    height: 130,
                                    child: PersonalAppointment(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                const Text(
                                  'Typical Doctor',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      height: 1.1),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 48,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: symptoms.length,
                                    itemBuilder: (ctx, index) {
                                      return InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: IntrinsicHeight(
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 8),
                                              decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xFFC9C9C9),
                                                    blurRadius: 1,
                                                    spreadRadius: 1,
                                                  ),
                                                ],
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(symptoms[index].name, style: const TextStyle(fontWeight: FontWeight.bold),),
                                                    const SizedBox(width: 4,),
                                                    Image.asset(symptoms[index].icon),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                AppointmentListPatient(),
                              ],
                            ),
                          ),
                        ],
                      );
                    });
              },
            ),
          ),
        ),
      ),
    );
  }
}
