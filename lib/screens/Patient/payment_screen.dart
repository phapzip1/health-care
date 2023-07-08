import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:health_care/bloc/app_bloc.dart";
import "package:health_care/bloc/app_state.dart";
import "package:health_care/screens/Patient/cards_and_wallets_screen.dart";
import "package:intl/intl.dart";

class PaymentScreen extends StatelessWidget {
  final String doctorId;
  final String doctorName;
  final int price;
  final String doctorPhone;
  final String doctorImage;
  final String doctorSpecialization;
  final DateTime date;
  final int hour;
  const PaymentScreen(
      this.doctorId,
      this.doctorName,
      this.price,
      this.doctorPhone,
      this.doctorImage,
      this.doctorSpecialization,
      this.date,
      this.hour,
      {super.key});

  @override
  Widget build(BuildContext context) {
    const double listtileVerticalPadding = 4.5;

    String time = hour % 10 == 3 ? '${hour ~/ 10}:30' : '${hour ~/ 10}:00';

    return Scaffold(
      body: BlocBuilder<AppBloc, AppState>(
          // future: PatientModel.getById(FirebaseAuth.instance.currentUser!.uid),
          builder: (ctx, state) {
        final patientUser = state.patient!;

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
                          child:
                              const Icon(Icons.arrow_back, color: Colors.black),
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
                              doctorName,
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
                              "$price vnd",
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
                            subtitle: Text(
                              "${DateFormat('dd-MM-y').format(date)}    $time",
                              style: const TextStyle(
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<AppBloc>(context),
                            child: CardsAndWalletsScreen(
                                doctorId,
                                doctorName,
                                price,
                                doctorPhone,
                                doctorImage,
                                doctorSpecialization,
                                date,
                                hour,
                                patientUser),
                          ),
                        ),
                      );
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
