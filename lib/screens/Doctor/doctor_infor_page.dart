import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/screens/Doctor/update_doctor_information.dart';
import 'package:health_care/screens/general/review_section.dart';
import 'package:health_care/widgets/infomation_page/upper_part.dart';

class DoctorInforPage extends StatefulWidget {
  const DoctorInforPage({super.key});
  @override
  State<DoctorInforPage> createState() => _DoctorInforPageState();
}

class _DoctorInforPageState extends State<DoctorInforPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (ctx, state) {
      final userDocs = state.doctor!;

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
          elevation: 1,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<AppBloc>(context),
                        child: UpdateDoctorInformation(doctor: state.doctor!),
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Color(0xFF3A86FF),
                ))
          ],
        ),
        body: SafeArea(
            child: ListView(
          children: [
            UpperPart(userDocs),
            const SizedBox(
              height: 8,
            ),
            Card(
              child: Column(children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Year of experience',
                            style: TextStyle(),
                          ),
                          Text(
                            '${userDocs.experience} years',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      // ignore: prefer_const_constructors
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Patients checked',
                            style: TextStyle(),
                          ),
                          FutureBuilder(
                            future: context.read<AppBloc>().appointmentProvider.getCompletedAppointmentCount(userDocs.id),
                            builder: (ctx, total) {
                              if (total.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              return Text(
                                total.data.toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ReviewSection(userDocs),
                    const SizedBox(
                      height: 16,
                    ),
                  ]),
                ),
              ]),
            ),
          ],
        )),
      );
    });
  }
}
