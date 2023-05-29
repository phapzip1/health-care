import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/widgets/comment_card.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorInforPage extends StatefulWidget {
  const DoctorInforPage(this.doctorId, {super.key});
  final doctorId;

  @override
  State<DoctorInforPage> createState() => _DoctorInforPageState();
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
              icon: const Icon(FontAwesomeIcons.chevronLeft)),
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
                  onPressed: () {}, icon: const Icon(FontAwesomeIcons.message)),
            ),
          ),
        ],
      ),
    );

Widget upperPart(doctor) => StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('doctor')
        .doc(doctor.id)
        .collection('reviews')
        .snapshots(),
    builder: (ctx, snapShot) {
      if (snapShot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (!snapShot.hasData) return Container();

      final userDocs = snapShot.data!.docs;
      return Card(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 56.0,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 48.0,
                  backgroundImage: NetworkImage(doctor['image_url']),
                ),
              ),
              Text(
                doctor['doctor_name'],
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
                        doctor['rating'].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
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
                        userDocs.length.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                doctor['workplace'],
                style: const TextStyle(
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
                  color: const Color(0xFFAEE6FF).withOpacity(0.5),
                ),
                child: Text(
                  doctor['specialization'],
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: Color(0xFF3A86FF)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Consultation price: ',
                    style: TextStyle(
                      color: Color(0xFF828282),
                    ),
                  ),
                  Text(
                    doctor['price'].toString(),
                    style: const TextStyle(
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
                    children: [
                      const Text(
                        'Consultations',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF828282)),
                      ),
                      Text(
                        doctor['patient_checked'].toString(),
                        style: const TextStyle(
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
    });

class _DoctorInforPageState extends State<DoctorInforPage> {
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
          child: FutureBuilder(
              future: Future.value(widget.doctorId),
              builder: (ctx, futureSnapShot) {
                if (futureSnapShot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('doctor')
                        .doc(widget.doctorId)
                        .snapshots(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData) return Container();

                      final userDocs = snapshot.data!;

                      return Column(
                        children: [
                          header(context),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  upperPart(userDocs),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Card(
                                    child: Column(children: [
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Year of experience',
                                                  style: TextStyle(),
                                                ),
                                                Text(
                                                  userDocs['experience']
                                                          .toString() +
                                                      ' years',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Patients checked',
                                                  style: TextStyle(),
                                                ),
                                                Text(
                                                  userDocs['patient_checked']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                textStyle: const TextStyle(
                                                    fontSize: 16),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(50)),
                                                ),
                                              ),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(DateFormat('dd/MM/y')
                                                        .format(selectedDate)),
                                                    const Icon(
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
                                        height: mediaQuery.width * 0.12,
                                        child: ListView.builder(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 2),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: time.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    right: 8),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xFFC9C9C9),
                                                      blurRadius: 0.5,
                                                      spreadRadius: 0.5,
                                                    ),
                                                  ],
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                child: Center(
                                                    child:
                                                        Text('${time[index]}')),
                                              );
                                            }),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                              
                                             StreamBuilder(
                                                        stream: FirebaseFirestore
                                                            .instance
                                                            .collection('doctor')
                                                            .doc(widget.doctorId)
                                                            .collection('reviews')
                                                            .snapshots(),
                                                        builder:
                                                            (ctx, snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return const Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          }

                                                          if (!snapshot
                                                                  .hasData ||
                                                              snapshot.data ==
                                                                  null ||
                                                              snapshot
                                                                  .data!
                                                                  .docs
                                                                  .isEmpty) {
                                                            return Container();
                                                          }

                                                          final comment =
                                                              snapshot
                                                                  .data!.docs;

                                                          return Container(
                                                            width:
                                                                double.infinity,
                                                            height: mediaQuery
                                                                    .width *
                                                                0.5,
                                                            child: ListView
                                                                .builder(
                                                                    itemCount:
                                                                        comment
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return CommendCard(comment[index]['reviewId'], 
                                                                      comment[index]['patient_name'],
                                                                      comment[index]['image_url']);
                                                                    }),
                                                          );
                                                        })
                                                  
                                            ]),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              })),
    );
  }
}