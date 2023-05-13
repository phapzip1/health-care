import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/widgets/comment_card.dart';
import 'package:intl/intl.dart';
import '../../models/doctor_info.dart';

class InfoDoctorViewPage extends StatefulWidget {
  final Doctor doctor;
  const InfoDoctorViewPage(this.doctor, {super.key});

  @override
  State<InfoDoctorViewPage> createState() => _InfoDoctorViewPageState();
}

const List<String> time = [
  '9:00 AM',
  '9:00 AM',
  '10:00 AM',
  '10:45 AM',
  '11:00 AM',
  '11:45 AM'
];

Widget header(context) => Container(
      padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(FontAwesomeIcons.chevronLeft)),
          const Text(
            'Doctor Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFE0E0E0),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Card(
              child: IconButton(
                  onPressed: () {}, icon: Icon(FontAwesomeIcons.message)),
            ),
          ),
        ],
      ),
    );

Widget upperPart(doctor) => Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 56.0,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 48.0,
                backgroundImage: AssetImage('assets/images/avatartUser.jpg'),
              ),
            ),
            Text(
              doctor.doctorName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.solidStar,
                      color: Color(0xFF3A86FF),
                      size: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      doctor.rating.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 24,
                ),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.solidMessage,
                      color: Color(0xFF3A86FF),
                      size: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      doctor.reviews.length.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Hospital Huu Nghi Viet Duc',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF828282)),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: Color(0xFFAEE6FF).withOpacity(0.5),
              ),
              child: Text(
                doctor.doctorSpecialization,
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Color(0xFF3A86FF)),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Consultation price: ',
                  style: TextStyle(
                    color: Color(0xFF828282),
                  ),
                ),
                Text(
                  '100.000d',
                  style: TextStyle(
                      color: Color(0xFF3A86FF), fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Appointments',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF828282)),
                    ),
                    Text(
                      '22',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Column(
                  children: const [
                    Text(
                      'Consultations',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF828282)),
                    ),
                    Text(
                      '0',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.red),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

class _InfoDoctorViewPageState extends State<InfoDoctorViewPage> {
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        header(context),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                upperPart(widget.doctor),
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
                                widget.doctor.experience.toString() + ' years',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Patients checked',
                                style: TextStyle(),
                              ),
                              Text(
                                widget.doctor.patientChecked.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Schedules',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              _selectDate(context);
                            },
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              textStyle: TextStyle(fontSize: 16),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DateFormat('dd/MM/y')
                                      .format(selectedDate)),
                                  Icon(
                                    FontAwesomeIcons.calendar,
                                    color: Colors.black,
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Time available',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: mediaQuery.width * 0.118,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: time.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(right: 8),
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFE0E0E0),
                                    blurRadius: 5,
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14)),
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Center(child: Text('${time[index]}')),
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Reviews',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: double.infinity,
                              height: mediaQuery.width * 0.5,
                              child: ListView.builder(
                                  itemCount: widget.doctor.reviews.length,
                                  itemBuilder: (context, index) {
                                    return CommendCard(
                                        widget.doctor.reviews[index]);
                                  }),
                            ),
                          ]),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ])),
    );
  }
}
