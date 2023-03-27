import 'package:flutter/material.dart';
import 'package:health_care/screens/Patient/updatePatientInformation.dart';

class PatientInformation extends StatefulWidget {
  const PatientInformation({super.key});

  @override
  State<PatientInformation> createState() => _PatientInformationState();
}

class _PatientInformationState extends State<PatientInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAEE6FF),
      body: SafeArea(
          child: Center(
        child: Stack(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
          ),
          Container(
            height: 410,
            child: Card(
              margin: const EdgeInsets.only(top: 48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                child: Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Do Pham Huy Khanh",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(30, 30),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const UpdatePatientInfo()));
                                },
                                child: const ImageIcon(
                                  AssetImage("assets/images/edit.png"),
                                  color: Color(0xFF3A86FF),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'Basic information',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.phone_rounded),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Phone Number:',
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                              width: 4,
                            ),
                            Text('0886667068', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: const [
                            ImageIcon(AssetImage("assets/images/gender.png")),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Gender:', style: TextStyle(fontSize: 16)),
                            SizedBox(
                              width: 4,
                            ),
                            Text('Male', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: const [
                            ImageIcon(AssetImage("assets/images/birthday.png")),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Birthday:', style: TextStyle(fontSize: 16)),
                            SizedBox(
                              width: 4,
                            ),
                            Text('26/04/2002', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          "Contact",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: const [
                            ImageIcon(AssetImage("assets/images/email.png")),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Email:', style: TextStyle(fontSize: 16)),
                            SizedBox(
                              width: 4,
                            ),
                            Text('khanhdph2604@gmail.com',
                                style: TextStyle(fontSize: 16)),
                          ],
                        )
                      ]),
                ),
              ),
            ),
          ),
          const Positioned(
              top: 5,
              left: 0,
              right: 0,
              child: SizedBox(
                child: CircleAvatar(
                  radius: 56.0,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 48.0,
                    backgroundImage:
                        AssetImage('assets/images/avatartUser.jpg'),
                  ),
                ),
              )),
        ]),
      )),
    );
  }
}
