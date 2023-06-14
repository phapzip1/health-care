import 'package:flutter/material.dart';
import 'package:health_care/widgets/function_category.dart';
import 'package:health_care/widgets/header_section.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePageDoctor extends StatefulWidget {
  const HomePageDoctor({super.key});

  @override
  State<HomePageDoctor> createState() => _HomePageDoctor();
}

class _HomePageDoctor extends State<HomePageDoctor> {
  final TextEditingController _searchController = TextEditingController();

  final String formattedTime = DateFormat.jm().format(DateTime.now());
  final String formattedDate = DateFormat.yMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: Future.value(user!.uid),
              builder: (ctx, futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('doctor')
                        .doc(user.uid)
                        .snapshots(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData) return Container();

                      final userDocs = snapshot.data!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeaderSection(
                                    url: userDocs['image'],
                                    userName: userDocs['name']),
                                FunctionCategory(userDocs.id, true),

                                // Appointment list
                                const Text(
                                  'My Appointment',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      height: 1.1),
                                ),
                              ],
                            ),
                          ),
                          // AppointmentListDoctor(),
                        ],
                      );
                    });
              }),
        ),
      ),
    ));
  }
}
