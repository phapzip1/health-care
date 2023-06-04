import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:health_care/models/doctor_model.dart";
import "package:health_care/models/patient_model.dart";
import "package:health_care/screens/cards_and_wallets_screen.dart";

class PaymentScreen extends StatelessWidget {
  final DoctorModel doctor;
  const PaymentScreen(this.doctor, {super.key});

  @override
  Widget build(BuildContext context) {
    const double listtileVerticalPadding = 4.5;
    return Scaffold(
      body: FutureBuilder(
          future: PatientModel.getById(FirebaseAuth.instance.currentUser!.uid),
          builder: (ctx, future) {
            if (future.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!future.hasData) return Container();

            final patientUser = future.data!;

            final patient = PatientModel(
                patientUser.id,
                patientUser.name,
                patientUser.phoneNumber,
                patientUser.gender,
                patientUser.birthdate,
                patientUser.email,
                patientUser.image);

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FloatingActionButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              elevation: 1,
                              child: const Icon(Icons.arrow_back,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 22),
                            const Text(
                              "Confirm Appointment",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 10),
                            leading: CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage(patientUser.image),
                            ),
                            title: const Text(
                              "Person visiting",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                            subtitle: Text(
                              patientUser.name,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: listtileVerticalPadding,
                                    horizontal: 10),
                                leading: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Image.asset(
                                    "assets/images/stethoscope.png",
                                    width: 32,
                                  ),
                                ),
                                title: const Text(
                                  "Doctor",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                                subtitle: Text(
                                  doctor.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                height: 1,
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: listtileVerticalPadding,
                                    horizontal: 10),
                                leading: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Image.asset(
                                    "assets/images/onlinemeeting.png",
                                    width: 32,
                                  ),
                                ),
                                title: const Text(
                                  "Way to consult",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                                subtitle: const Text(
                                  "Video call",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                height: 1,
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: listtileVerticalPadding,
                                    horizontal: 10),
                                leading: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Image.asset(
                                    "assets/images/firstaidbox.png",
                                    width: 32,
                                  ),
                                ),
                                title: const Text(
                                  "Cost",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                                subtitle: Text(
                                  "${doctor.price} vnd",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                height: 1,
                              ),
                              ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: listtileVerticalPadding,
                                    horizontal: 10),
                                leading: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Image.asset(
                                    "assets/images/clock.png",
                                    width: 32,
                                  ),
                                ),
                                ///////// need to be change
                                title: const Text(
                                  "Time",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                                subtitle: const Text(
                                  "2023-12-11 08:00AM",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 20,
                      right: 20,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CardsAndWalletsScreen(doctor, patient)));
                        },
                        child: const Padding(
                          padding: EdgeInsetsDirectional.symmetric(vertical: 5),
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
