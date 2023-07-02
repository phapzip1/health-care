// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/models/review_model.dart';
import 'package:health_care/screens/general/review_section.dart';
import 'package:health_care/services/navigation_service.dart';
import 'package:health_care/widgets/infomation_page/time_choosing.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DoctorInforPage extends StatefulWidget {
  const DoctorInforPage(this.doctorId, this.isDoctor, {super.key});
  final String doctorId;
  final bool isDoctor;

  @override
  State<DoctorInforPage> createState() => _DoctorInforPageState();
}

final user = FirebaseAuth.instance.currentUser;
final _nameController = TextEditingController();
final _workplaceController = TextEditingController();
final _specializationController = TextEditingController();
final _priceController = TextEditingController();
final _experienceController = TextEditingController();

Widget upperPart(doctor, isDoctor, context) => Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 56.0,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 48.0,
                backgroundImage: NetworkImage(doctor.image),
              ),
            ),
            isDoctor
                ? TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(border: InputBorder.none),
                  )
                : Text(
                    doctor.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            const SizedBox(
              height: 16,
            ),
            // ignore: prefer_const_constructors
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
                    // ignore: prefer_const_constructors
                    FutureBuilder(
                        future: ReviewModel.getAverageRating(doctor.id),
                        builder: (ctx, rating) {
                          if (rating.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          return Text(
                            rating.data.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          );
                        }),
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
                    FutureBuilder(
                      future: ReviewModel.getTotalReview(doctor.id),
                      builder: (ctx, review) => Text(
                        review.data.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            isDoctor
                ? TextField(
                    controller: _workplaceController,
                    decoration: const InputDecoration(border: InputBorder.none),
                  )
                : Text(
                    doctor.workplace,
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
              child: isDoctor
                  ? TextField(
                      controller: _specializationController,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    )
                  : Text(
                      doctor.specialization,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3A86FF)),
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
                isDoctor
                    ? TextField(
                        controller: _priceController,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      )
                    : Text(
                        "${doctor.price} vnd",
                        style: const TextStyle(
                            color: Color(0xFF3A86FF),
                            fontWeight: FontWeight.bold),
                      )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );

class _DoctorInforPageState extends State<DoctorInforPage> {
  DateTime _selectedDate = DateTime.now();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: now,
      lastDate: now.add(
        const Duration(days: 7),
      ),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  int _choosingTime = -1;

  void _onChange(index) {
    _choosingTime = index;
  }

  @override
  void initState() {
    // TODO: implement initState
    // _nameController.text =
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
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
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: widget.isDoctor ? false : true,
        iconTheme: IconThemeData(
          color: widget.isDoctor ? Colors.white : Colors.black,
        ),
        actions: [
          widget.isDoctor
              ? TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              : Container()
        ],
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: DoctorModel.getById(widget.doctorId),
              builder: (ctx, futureSnapShot) {
                if (futureSnapShot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!futureSnapShot.hasData) {
                  return Container();
                }

                final userDocs = futureSnapShot.data!;

                return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 56.0,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 48.0,
                                    backgroundImage:
                                        NetworkImage(userDocs.image),
                                  ),
                                ),
                                widget.isDoctor
                                    ? TextField(
                                        controller: _nameController,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none),
                                      )
                                    : Text(
                                        userDocs.name,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                const SizedBox(
                                  height: 16,
                                ),
                                // ignore: prefer_const_constructors
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
                                        // ignore: prefer_const_constructors
                                        FutureBuilder(
                                            future:
                                                ReviewModel.getAverageRating(
                                                    userDocs.id!),
                                            builder: (ctx, rating) {
                                              if (rating.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const CircularProgressIndicator();
                                              }
                                              return Text(
                                                rating.data.toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15),
                                              );
                                            }),
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
                                        FutureBuilder(
                                          future: ReviewModel.getTotalReview(
                                              userDocs.id!),
                                          builder: (ctx, review) => Text(
                                            review.data.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                widget.isDoctor
                                    ? TextField(
                                        controller: _workplaceController,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none),
                                      )
                                    : Text(
                                        userDocs.workplace,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF828282)),
                                      ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    color: const Color(0xFFAEE6FF)
                                        .withOpacity(0.5),
                                  ),
                                  child: widget.isDoctor
                                      ? TextField(
                                          controller: _specializationController,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none),
                                        )
                                      : Text(
                                          userDocs.specialization,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF3A86FF)),
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
                                    widget.isDoctor
                                        ? TextField(
                                            controller: _priceController,
                                            decoration: const InputDecoration(
                                                border: InputBorder.none),
                                          )
                                        : Text(
                                            "${userDocs.price} vnd",
                                            style: const TextStyle(
                                                color: Color(0xFF3A86FF),
                                                fontWeight: FontWeight.bold),
                                          )
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Year of experience',
                                        style: TextStyle(),
                                      ),
                                      widget.isDoctor
                                          ? TextField(
                                              controller: _experienceController,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none),
                                            )
                                          : Text(
                                              '${userDocs.experience} years',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  // ignore: prefer_const_constructors
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Patients checked',
                                        style: TextStyle(),
                                      ),
                                      FutureBuilder(
                                        future: AppointmentModel
                                            .countTotalAppointmentHistory(
                                                doctorId: userDocs.id),
                                        builder: (ctx, total) => Text(
                                          total.data.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  widget.isDoctor
                                      ? Container()
                                      : const Text(
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
                                      textStyle: const TextStyle(fontSize: 16),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                      ),
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(DateFormat('dd/MM/y')
                                              .format(_selectedDate)),
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
                            FutureBuilder(
                                future: userDocs.checkTime(),
                                builder: (ctx, futureCheck) {
                                  if (futureCheck.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (futureCheck.data!) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                      ),
                                      onPressed: () {
                                        NavigationService.navKey.currentState
                                            ?.pushNamed('/schedule',
                                                arguments: userDocs.id);
                                      },
                                      child: const Text(
                                        'Choose your time for consultant',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    );
                                  }

                                  return FutureBuilder(
                                      future: userDocs.getAvailableTime(
                                        _selectedDate.day,
                                        _selectedDate.month,
                                        _selectedDate.year,
                                      ),
                                      builder: (ctx, future) {
                                        if (future.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        final time = future.data!;
                                        return time.isEmpty
                                            ? const Text(
                                                'There is no time frame available')
                                            : TimeChoosing(
                                                time,
                                                mediaQuery,
                                                _selectedDate.day,
                                                _selectedDate.month,
                                                _selectedDate.year,
                                                _onChange,
                                                widget.isDoctor);
                                      });
                                }),
                            const SizedBox(
                              height: 16,
                            ),
                            !widget.isDoctor
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                    ),
                                    onPressed: () {
                                      //payment screen
                                      _choosingTime == -1
                                          ? Fluttertoast.showToast(
                                              msg: "You must choose time",
                                              toastLength: Toast.LENGTH_SHORT,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0,
                                            )
                                          : NavigationService
                                              .navKey.currentState
                                              ?.pushNamed('/payment',
                                                  arguments: {
                                                  'doctorId': userDocs.id,
                                                  'doctorName': userDocs.name,
                                                  'price': userDocs.price,
                                                  'doctorPhone':
                                                      userDocs.phoneNumber,
                                                  'doctorImage': userDocs.image,
                                                  'doctorSpecialization':
                                                      userDocs.specialization,
                                                  'date': _selectedDate,
                                                  'hour': _choosingTime
                                                });
                                    },
                                    child: const Text(
                                      'Make appointment',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ))
                                : Container(),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              // ignore: prefer_const_constructors
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
                    ),
                  ),
                );
              })),
    );
  }
}
