import 'package:flutter/material.dart';
import 'package:health_care/models/patient_model.dart';

import 'package:health_care/models/symptom.dart';
import 'package:health_care/widgets/function_category.dart';
import 'package:health_care/widgets/home_page/personal_appointment.dart';

import '../../widgets/home_page/appointment_list_patient.dart';
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
  int _selectedIndex = 0;

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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      margin: const EdgeInsets.only(bottom: 4),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: symptoms.length,
                              itemBuilder: (ctx2, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                  },
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
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                symptoms[index].name,
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Image.network(
                                                symptoms[index].icon,
                                                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                                  if (wasSynchronouslyLoaded) {
                                                    return child;
                                                  }
                                                  return Image.asset("assets/images/fallback.jpg");
                                                },
                                                width: 24,
                                              )
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
                          if (symptoms.isNotEmpty)
                            AppointmentListPatient(spec: symptoms[_selectedIndex].name),
                        ],
                      ),
                    ),
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
