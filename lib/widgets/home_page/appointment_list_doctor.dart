
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class AppointmentListDoctor extends StatelessWidget {
//   const AppointmentListDoctor({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // final mediaQuery = MediaQuery.of(context).size;

//     return FutureBuilder(
//       future: null,
//       builder: (context, snapshot) {
//         return Container(
//                   margin: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16),
//                   decoration: const BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0xFFC9C9C9),
//                         blurRadius: 1,
//                         spreadRadius: 0.8,
//                       ),
//                     ],
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(10))
//                   ),
//                   // ignore: sort_child_properties_last
//                   child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const CircleAvatar(
//                                 radius: 28.0,
//                                 backgroundImage:
//                                     AssetImage('assets/images/avatartUser.jpg'),
//                               ),
//                               const SizedBox(
//                                 width: 16,
//                               ),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       e.patient.patientName,
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16),
//                                     ),
//                                     const SizedBox(
//                                       height: 12,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             const Icon(
//                                               FontAwesomeIcons.calendar,
//                                               size: 20,
//                                             ),
//                                             const SizedBox(
//                                               width: 4,
//                                             ),
//                                             Text(
//                                               e.day,
//                                               style: const TextStyle(fontSize: 16),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             const Icon(
//                                               FontAwesomeIcons.clock,
//                                               size: 20,
//                                             ),
//                                             const SizedBox(
//                                               width: 4,
//                                             ),
//                                             Text(
//                                               e.time,
//                                               style: const TextStyle(fontSize: 16),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           Row(
//                             children: [
//                               const Text(
//                                 'Issues:',
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                               const SizedBox(
//                                 width: 4,
//                               ),
//                               Text(
//                                 e.issues,
//                                 style: const TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
                
                  
//                 );
//       }
//     ),
      
//     );
//   }
// }
