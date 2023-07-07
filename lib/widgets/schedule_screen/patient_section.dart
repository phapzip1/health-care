import 'package:flutter/material.dart';

import 'package:health_care/models/appointment_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:health_care/widgets/schedule_screen/header.dart';

class PatientSection extends StatefulWidget {
  const PatientSection(this.scheduleDocs, {super.key});

  final List<AppointmentModel> scheduleDocs;

  @override
  State<PatientSection> createState() => _PatientSectionState();
}

class _PatientSectionState extends State<PatientSection> {
  bool _changedPage = true;

  void _click(value) {
    setState(() {
      _changedPage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var filterList;
    final now = DateTime.now();
    if (_changedPage) {
      filterList = widget.scheduleDocs
          .where((element) =>
              element.datetime.isBefore(now) && element.status <= 1)
          .toList();
    } else {
      filterList = widget.scheduleDocs
          .where(
              (element) => element.datetime.isAfter(now) || element.status > 1)
          .toList();
    }

    return Column(
      children: [
        Header(_click, _changedPage),
        Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filterList.length,
                itemBuilder: (ctx, index) {
                  return InkWell(
                    // onTap: () => NavigationService.navKey.currentState
                    //     ?.pushNamed('/appointmentdetailforpatient',
                    //         arguments: filterList[index]),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFC9C9C9),
                            blurRadius: 1,
                            spreadRadius: 1,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        filterList[index].doctorName,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        filterList[index].specialization,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF828282)),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        filterList[index].doctorPhone,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 26.0,
                                  backgroundImage: NetworkImage(
                                      filterList[index].doctorImage),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.calendar,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      filterList[index]
                                          .dateTime
                                          .toString()
                                          .substring(0, 10),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.clock,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      filterList[index]
                                          .dateTime
                                          .toString()
                                          .substring(10, 16),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 4,
                                      backgroundColor:
                                          filterList[index].status == 0
                                              ? const Color(0xFFE2B93B)
                                              : const Color(0xFF27AE60),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      filterList[index].status == 0
                                          ? "Waiting"
                                          : filterList[index].status == 1
                                              ? "Confirmed"
                                              : "Rejected",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            // widget.changedPage
                            //     ? Column(
                            //         children: [
                            //           filterList[index].status == 0
                            //               ? ElevatedButton(
                            //                   style: ElevatedButton.styleFrom(
                            //                     backgroundColor:
                            //                         const Color(0xFFE0E0E0),
                            //                     elevation: 0,
                            //                   ),
                            //                   onPressed: () {
                            //                     FirebaseFirestore.instance
                            //                         .collection('patient')
                            //                         .doc(user!.uid)
                            //                         .collection('schedule')
                            //                         .doc(filterList[index].id)
                            //                         .delete();
                            //                   },
                            //                   child: const Align(
                            //                     alignment: Alignment.center,
                            //                     child: Text(
                            //                       'Cancel',
                            //                       style: TextStyle(
                            //                         fontWeight: FontWeight.bold,
                            //                         color: Colors.black,
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 )
                            //               : Row(
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.spaceEvenly,
                            //                   children: [
                            //                     ///Button Cancel
                            //                     if (now.isBefore(meeting.subtract(
                            //                         const Duration(minutes: 30))))
                            //                       ElevatedButton(
                            //                           style: ElevatedButton.styleFrom(
                            //                               backgroundColor:
                            //                                   const Color(0xFFFFBE0B),
                            //                               elevation: 0,
                            //                               padding: EdgeInsets.symmetric(
                            //                                   horizontal:
                            //                                       MediaQuery.of(context)
                            //                                               .size
                            //                                               .width *
                            //                                           0.05,
                            //                                   vertical: 12)),
                            //                           onPressed: () {},
                            //                           child: const Text(
                            //                             'Cancel',
                            //                             style: TextStyle(
                            //                                 fontWeight: FontWeight.bold,
                            //                                 color: Colors.black,
                            //                                 fontSize: 16),
                            //                           )),
                            //                     if (now.isBefore(meeting.subtract(
                            //                         const Duration(minutes: 5))))
                            //                       ElevatedButton(
                            //                         style: ElevatedButton.styleFrom(
                            //                             backgroundColor:
                            //                                 const Color(0xFF2F80ED),
                            //                             elevation: 0,
                            //                             padding: EdgeInsets.symmetric(
                            //                                 horizontal:
                            //                                     MediaQuery.of(context)
                            //                                             .size
                            //                                             .width *
                            //                                         0.05,
                            //                                 vertical: 12)),
                            //                         onPressed: () {
                            //                           NavigationService
                            //                               .navKey.currentState
                            //                               ?.pushNamed('/chat',
                            //                                   arguments:
                            //                                       filterList[index]);
                            //                         },
                            //                         child: const Text(
                            //                           'Send message',
                            //                           style: TextStyle(
                            //                             color: Colors.white,
                            //                             fontWeight: FontWeight.bold,
                            //                             fontSize: 16,
                            //                           ),
                            //                         ),
                            //                       ),
                            //                   ],
                            //                 ),
                            //         ],
                            //       )
                            //     : ReviewModal(
                            //         filterList[index].doctorId,
                            //         filterList[index].patientId,
                            //         filterList[index].patientName,
                            //         filterList[index].patientImage),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
      ],
    );
  }
}
