import 'package:flutter/material.dart';
import 'package:health_care/screens/Patient/new_appointment.dart';
import 'package:health_care/screens/Patient/patientRecord.dart';
import 'package:health_care/screens/communityQA.dart';

class FunctionCategory extends StatelessWidget {
  const FunctionCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewAppointment()),
              );
            },
            child: Column(
              children: [
                Container(
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
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    "assets/images/doctor.png",
                    width: 36,
                  ),
                ),
                const Text(
                  'Make\nappointment',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommunityQA()),
              );
            },
            child: Column(
              children: [
                Container(
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
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    "assets/images/question.png",
                    width: 36,
                  ),
                ),
                const Text(
                  'Public\nquestions',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PatientRecords()),
              );
            },
            child: Column(
              children: [
                Container(
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
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    "assets/images/insurance.png",
                    width: 36,
                  ),
                ),
                const Text(
                  'Health\n records',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
