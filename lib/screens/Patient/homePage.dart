import 'package:flutter/material.dart';
import 'package:health_care/widgets/appointment_list_patient.dart';
import 'package:health_care/widgets/header_section.dart';
import 'package:intl/intl.dart';
import '../../models/appointment_patient.dart';
import '../../models/doctor_info.dart';
import '../../models/reivew.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  final Doctor doctor1 =
      Doctor('123', 'Dr. Chris Frazier', 'Pediatrician', 4.5, 20, 198, [
    new DateTime(2023, 6, 25, 9, 30),
    new DateTime(2023, 6, 15, 8, 30)
  ], [
    Review(
        name: 'khanh',
        timePosted: new DateTime(2023, 6, 25, 9, 30),
        rating: 4.5,
        context: 'contextcontextcontextcontextcontextcontextcontext')
  ]);

  final List<Doctor> appointmentList = [
    Doctor('123', 'Dr. Chris Frazier', 'Pediatrician', 4.5, 20, 198, [
      new DateTime(2023, 6, 25, 9, 30),
      new DateTime(2023, 6, 15, 8, 30)
    ], [
      Review(
          name: 'khanh',
          timePosted: new DateTime(2023, 6, 25, 9, 30),
          rating: 4.5,
          context: 'contextcontextcontextcontextcontextcontextcontext')
    ]),
    Doctor('123', 'Dr. Chris Frazier', 'Pediatrician', 4.5, 20, 198, [
      new DateTime(2023, 6, 25, 9, 30),
      new DateTime(2023, 6, 15, 8, 30)
    ], [
      Review(
          name: 'khanh',
          timePosted: new DateTime(2023, 6, 25, 9, 30),
          rating: 4.5,
          context: 'contextcontextcontextcontextcontextcontextcontext')
    ]),
    Doctor('123', 'Dr. Chris Frazier', 'Pediatrician', 4.5, 20, 198, [
      new DateTime(2023, 6, 25, 9, 30),
      new DateTime(2023, 6, 15, 8, 30)
    ], [
      Review(
          name: 'khanh',
          timePosted: new DateTime(2023, 6, 25, 9, 30),
          rating: 4.5,
          context: 'contextcontextcontextcontextcontextcontextcontext')
    ])
  ];
  final String formattedTime = DateFormat.jm().format(DateTime.now());
  final String formattedDate = DateFormat.yMd().format(DateTime.now());

  late PatientAppointment appointment1 =
      PatientAppointment(formattedTime, doctor1, 1, formattedDate);

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context).size;
    final cardAppointment = Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),

      // ignore: sort_child_properties_last
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Color(0xFFAEE6FF),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 28.0,
                    backgroundImage:
                        AssetImage('assets/images/avatartUser.jpg'),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment1.doctor.doctorName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        appointment1.doctor.doctorSpecialization,
                        style: const TextStyle(
                            color: Color(0xFF828282), fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.clock,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(appointment1.time.toString()),
                      const SizedBox(width: 8,),
                      Text(appointment1.day.toString())
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE0E0E9),
            blurRadius: 10.0,
          ),
        ],
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // ignore: prefer_const_constructors
              HeaderSection(
                  url: 'assets/images/avatartUser.jpg',
                  userName: 'Do Pham Huy Khanh'),

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
              const SizedBox(
                height: 16,
              ),
              //Sẽ cần 1 vòng lặp lấy ra các appointment
              //     ListView.builder(
              //   itemCount: products.length,
              //   itemBuilder: (context, index) {
              //     return ListTile(
              //       title: Text('${products[index]}'),
              //     );
              //   },
              // ),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  cardAppointment,
                  cardAppointment,
                  cardAppointment,
                ]),
              ),

              //Doctoc list and symptoms sections
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Typical Doctor',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, height: 1.1),
              ),

              AppointmentListPatient(appointmentList),
            ]),
          ),
        ),
      ),
    );
  }
}
