import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
// import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/bloc/app_state.dart';
// import 'package:health_care/models/patient_model.dart';

import 'package:health_care/screens/general/typical_doctor.dart';
import 'package:health_care/widgets/function_category.dart';
import 'package:health_care/widgets/home_page/personal_appointment.dart';
import 'package:health_care/widgets/header_section.dart';

import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SingleChildScrollView(
            child: BlocBuilder<AppBloc, AppState>(
              // future: PatientModel.getById(user!.uid),
              builder: (ctx, state) {
                final symptoms = state.symptom!;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderSection(
                              url: state.patient!.image,
                              userName: state.patient!.name),
                          FunctionCategory(user.uid, false),
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
