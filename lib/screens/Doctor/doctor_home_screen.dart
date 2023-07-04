import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/widgets/function_category.dart';
import 'package:health_care/widgets/header_section.dart';
import 'package:health_care/widgets/home_page/appointment_list_doctor.dart';
import 'package:intl/intl.dart';


class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreen();
}

class _DoctorHomeScreen extends State<DoctorHomeScreen> {
  final String formattedTime = DateFormat.jm().format(DateTime.now());
  final String formattedDate = DateFormat.yMd().format(DateTime.now());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: SingleChildScrollView(
          child: BlocBuilder<AppBloc, AppState>(
              // future: DoctorModel.getById(user!.uid),
              builder: (ctx, state) {
            final userDocs = state.doctor!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderSection(
                          url: userDocs.image, userName: userDocs.name),
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
                AppointmentListDoctor(),
              ],
            );
          }),
        ),
      ),
    ));
  }
}
