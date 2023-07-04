import 'package:flutter/material.dart';
import 'package:health_care/models/patient_model.dart';

import 'package:health_care/models/symptom.dart';
import 'package:health_care/screens/general/typical_doctor.dart';
import 'package:health_care/widgets/function_category.dart';
import 'package:health_care/widgets/home_page/personal_appointment.dart';
import 'package:health_care/widgets/header_section.dart';

import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  late List<Symptom> symptoms;

  @override
  void initState() {
    super.initState();
    symptoms = [];
    loadSymtoms();
  }

  void loadSymtoms() async {
    final list = await SymptomsProvider.getSymtoms();
    setState(() {
      symptoms.addAll(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: PatientModel.getById(user!.uid),
              builder: (ctx, futureSnapShot) {
                if (futureSnapShot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderSection(url: futureSnapShot.data!.image, userName: futureSnapShot.data!.name),
                          FunctionCategory(user!.uid, false),
                          const Text(
                            'My Appointment',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.1),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const SizedBox(
                            width: double.infinity,
                            height: 130,
                            child: PersonalAppointment(),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            'Typical Doctor',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.1),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    TypicalDoctor(symptoms)
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
