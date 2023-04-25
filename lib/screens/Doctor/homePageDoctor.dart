import 'package:flutter/material.dart';
import 'package:health_care/models/appointment_doctor.dart';
import 'package:health_care/widgets/header_section.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/patient_info.dart';
import '../../widgets/appointment_list_doctor.dart';
import 'package:intl/intl.dart';

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
    final List<DoctorAppointment> appointmentList = [
      DoctorAppointment(
          formattedDate.toString(),
          formattedTime.toString(),
          new Patient(
            '123456',
            'Nguyen Huynh Tuan Khang',
            'Male',
            0886667068,
            '26/04/2002',
            'khanhdph2604@gmail.com',
          ),
          1,
          'headache'),
      DoctorAppointment(
          formattedDate.toString(),
          formattedTime.toString(),
          new Patient(
            '123456',
            'Nguyen Huynh Tuan Khang',
            'Male',
            0886667068,
            '26/04/2002',
            'khanhdph2604@gmail.com',
          ),
          1,
          'headache'),
      DoctorAppointment(
          formattedDate.toString(),
          formattedTime.toString(),
          new Patient(
            '123456',
            'Nguyen Huynh Tuan Khang',
            'Male',
            0886667068,
            '26/04/2002',
            'khanhdph2604@gmail.com',
          ),
          1,
          'headache'),
      DoctorAppointment(
          formattedDate.toString(),
          formattedTime.toString(),
          new Patient(
            '123456',
            'Nguyen Huynh Tuan Khang',
            'Male',
            0886667068,
            '26/04/2002',
            'khanhdph2604@gmail.com',
          ),
          1,
          'headache'),
      DoctorAppointment(
          formattedDate.toString(),
          formattedTime.toString(),
          new Patient(
            '123456',
            'Nguyen Huynh Tuan Khang',
            'Male',
            0886667068,
            '26/04/2002',
            'khanhdph2604@gmail.com',
          ),
          1,
          'headache'),
    ];

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            HeaderSection(url: 'assets/images/avatartUser.jpg', userName: 'Anna Baker'),
            Container(
              margin: const EdgeInsets.only(top: 32, bottom: 32),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _searchController.clear(),
                  ),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      // Perform the search here
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),

            // Appointment list
            const Text(
              'My Appointment',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, height: 1.1),
            ),
            AppointmentListDoctor(appointmentList: appointmentList)
          ]),
        ),
      ),
    ));
  }
}
