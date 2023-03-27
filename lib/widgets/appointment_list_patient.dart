import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/models/doctor_info.dart';

class AppointmentListPatient extends StatelessWidget {
  final List<Doctor> appointmentList;

  AppointmentListPatient(this.appointmentList);

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: appointmentList
            .map((e) => Container(
              margin: const EdgeInsets.only(top: 16),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: const Image(
                                image:
                                    AssetImage('assets/images/avatartUser.jpg'),
                                height: 64,
                                width: 56,
                              ),
                            ),
                            Column(
                              children: [
                                Text(e.doctorName),
                                Text(e.doctorSpecialization),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.star,
                                      color: Colors.yellow,
                                      size: 20,
                                    ),
                                    const Icon(
                                      FontAwesomeIcons.star,
                                      color: Colors.yellow,
                                      size: 20,
                                    ),
                                    const Icon(
                                      FontAwesomeIcons.star,
                                      color: Colors.yellow,
                                      size: 20,
                                    ),
                                    const Icon(
                                      FontAwesomeIcons.star,
                                      color: Colors.yellow,
                                      size: 20,
                                    ),
                                    const Icon(
                                      FontAwesomeIcons.star,
                                      color: Colors.yellow,
                                      size: 20,
                                    ),
                                    Text(e.rating.toString()),
                                    const Text(
                                      '120 Reviews',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF828282)),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Consultation price:',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF828282)),
                                    ),
                                    Text('100.000 VND',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
