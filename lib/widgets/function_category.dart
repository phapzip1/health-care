import 'package:flutter/material.dart';
import 'package:health_care/screens/Patient/new_appointment.dart';
import 'package:health_care/screens/Patient/patientRecord.dart';
import 'package:health_care/screens/communityQA.dart';

class FunctionCategory extends StatelessWidget {
  final String id;
  final bool isDoctor;
  const FunctionCategory(this.id, this.isDoctor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isDoctor ? MainAxisAlignment.spaceBetween: MainAxisAlignment.start,
        children: [
          isDoctor
              ? Container()
              : Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewAppointment(id)),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(
                              "assets/images/doctor.png",
                              width: 36,
                            ),
                          ),
                          const Text(
                            'Make\nconsultation',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: InkWell(
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
            ),
          ),
          Expanded(
            child: Align(
              alignment: isDoctor ?Alignment.center : Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PatientRecords(id)),
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
            ),
          ),
        ],
      ),
    );
  }
}
