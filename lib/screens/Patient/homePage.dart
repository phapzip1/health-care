import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health_care/widgets/appointment_list_patient.dart';
import '../../models/appointment_patient.dart';
import '../../models/doctor_info.dart';
import '../../models/reivew.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class Symptoms {
  // late FontAwesomeIcons icon;
  late String icon;
  late String name;

  Symptoms({required this.icon, required this.name});
  // Symptoms({required this.name});
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
        context: 'a')
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
          context: 'a')
    ]),
    Doctor('123', 'Dr. Chris Frazier', 'Pediatrician', 4.5, 20, 198, [
      new DateTime(2023, 6, 25, 9, 30),
      new DateTime(2023, 6, 15, 8, 30)
    ], [
      Review(
          name: 'khanh',
          timePosted: new DateTime(2023, 6, 25, 9, 30),
          rating: 4.5,
          context: 'a')
    ]),
    Doctor('123', 'Dr. Chris Frazier', 'Pediatrician', 4.5, 20, 198, [
      new DateTime(2023, 6, 25, 9, 30),
      new DateTime(2023, 6, 15, 8, 30)
    ], [
      Review(
          name: 'khanh',
          timePosted: new DateTime(2023, 6, 25, 9, 30),
          rating: 4.5,
          context: 'a')
    ])
  ];

  late PatientAppointment appointment1 =
      PatientAppointment(new DateTime(2023, 6, 25, 9, 30), doctor1, 1);

  final List<Symptoms> listSymtoms = [
    Symptoms(icon: 'assets/images/headache.png', name: 'Headache'),
    Symptoms(icon: 'assets/images/sneezing.png', name: 'Snuffle'),
    Symptoms(icon: 'assets/images/stomachache.png', name: 'Stomachache'),
    Symptoms(icon: 'assets/images/all.png', name: 'All'),
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
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
                    children: [
                      const Icon(
                        FontAwesomeIcons.clock,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(appointment1.timeAppointment.toString())
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
              Row(
                children: [
                  const CircleAvatar(
                    radius: 32.0,
                    backgroundImage:
                        AssetImage('assets/images/avatartUser.jpg'),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Good Morning,',
                        style: TextStyle(
                          color: Color(0xFF828282),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Do Pham Huy Khanh',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                'What are your Symptoms ?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),

              Container(
                height: mediaQuery.height > 600 ? 50 : mediaQuery.height * 0.06,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 16,
                  ),
                  itemCount: listSymtoms.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFBDBDBD),
                              blurRadius: 3.0,
                              spreadRadius: 1,
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              textStyle: MaterialStateProperty.all(
                                  const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(8)),
                              elevation: MaterialStateProperty.all<double>(0)),
                          onPressed: () {},
                          icon: Image.asset(
                            listSymtoms[index].icon,
                            width: 16,
                          ),
                          label: Text('${listSymtoms[index].name}'),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              AppointmentListPatient(appointmentList),
            ]),
          ),
        ),
      ),
    );
  }
}
