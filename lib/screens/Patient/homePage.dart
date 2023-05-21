import 'package:flutter/material.dart';
import 'package:health_care/widgets/home_page/personal_appointment.dart';
import 'package:health_care/widgets/search.dart';
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

  final TextEditingController _searchController = TextEditingController();

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
                                Search(_searchController),
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
                                    height: 140,
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
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: AppointmentListPatient(),
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
