// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:health_care/screens/chat.dart';
// import '../models/appointment_doctor.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class ListCardScheduleForDoctor extends StatelessWidget {
//   const ListCardScheduleForDoctor(this.appointmentList, {super.key});

//   final List<DoctorAppointment> appointmentList;

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context).size;

//     return ListView(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       children: appointmentList
//           .map((e) => Container(
//                 margin: const EdgeInsets.only(bottom: 16.0),
//                 decoration: const BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0xFFE0E0E0),
//                       blurRadius: 5,
//                       spreadRadius: 1,
//                     ),
//                   ],
//                   borderRadius: BorderRadius.all(Radius.circular(20)),
//                 ),
//                 child: InkWell(
//                   onTap: () => {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => ChatScreen()))
//                   },
//                   child: Card(
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(16),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       e.patient.patientName,
//                                       style: const TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 6,
//                                     ),
//                                     Text(
//                                       'Issues: ' + e.issues,
//                                       style: const TextStyle(
//                                           fontSize: 16,
//                                           color: Color(0xFF828282)),
//                                     ),
//                                     const SizedBox(
//                                       height: 6,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const CircleAvatar(
//                                 radius: 26.0,
//                                 backgroundImage:
//                                     AssetImage('assets/images/avatartUser.jpg'),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 4,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   const Icon(
//                                     FontAwesomeIcons.calendar,
//                                     size: 20,
//                                   ),
//                                   const SizedBox(
//                                     width: 4,
//                                   ),
//                                   Text(
//                                     e.day,
//                                     style: const TextStyle(fontSize: 16),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   const Icon(
//                                     FontAwesomeIcons.clock,
//                                     size: 20,
//                                   ),
//                                   const SizedBox(
//                                     width: 4,
//                                   ),
//                                   Text(
//                                     e.time,
//                                     style: const TextStyle(fontSize: 16),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   CircleAvatar(
//                                     radius: 4,
//                                     backgroundColor: e.status == 0
//                                         ? Color(0xFFE2B93B)
//                                         : e.status == 1
//                                             ? Color(0xFF27AE60)
//                                             : Color(0xFFEB5757),
//                                   ),
//                                   const SizedBox(
//                                     width: 4,
//                                   ),
//                                   Text(
//                                     e.status == 0
//                                         ? 'Waiting'
//                                         : e.status == 1
//                                             ? 'Confirmed'
//                                             : 'Rejected',
//                                     style: const TextStyle(fontSize: 16),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Color(0xFFE0E0E0),
//                                   elevation: 0,
//                                   // padding: EdgeInsets.symmetric(vertical: 8)
//                                 ),
//                                 onPressed: () {},
//                                 child: Container(
//                                   width: e.status == 0 ? mediaQuery.width * 0.38 : double.infinity,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: const [
//                                       Text(
//                                         'Cancle',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               e.status == 0 ? ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Color(0xFF3A86FF),
//                                   elevation: 0,
//                                 ),
//                                 onPressed: () {},
//                                 child: Container(
//                                   width: mediaQuery.width * 0.38,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: const [
//                                       Text(
//                                         'Confirm',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ) : Container(),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ))
//           .toList(),
//     );
//   }
// }
