import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:health_care/bloc/app_bloc.dart";
import "package:health_care/bloc/app_event.dart";
import "package:health_care/main.dart";
import "package:health_care/models/patient_model.dart";


class CardsAndWalletsScreen extends StatelessWidget {
  final String doctorId;
  final String doctorName;
  final int price;
  final String doctorPhone;
  final String doctorImage;
  final String specialization;
  final DateTime datetime;
  final PatientModel patient;

  const CardsAndWalletsScreen(this.doctorId, this.doctorName, this.price, this.doctorPhone, this.doctorImage, this.specialization, this.datetime, this.patient, {super.key});

  void _makeAppointment(BuildContext context) async {
    context.read<AppBloc>().add(
          AppEventMakeAppointment(
            doctorId,
            doctorName,
            doctorPhone,
            doctorImage,
            patient.id.toString(),
            patient.name,
            patient.image,
            patient.phoneNumber,
            specialization,
            price.toDouble(),
            datetime,
          ),
        );
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<AppBloc>(context),
          child: const HomePage(),
        ),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        elevation: 1,
                        child: const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      const SizedBox(width: 22),
                      const Text(
                        "Payment method",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "Fee of consultance:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF828282),
                        ),
                      ),
                      Text(
                        "${price} vnd",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFEB5757),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: screenHeight * 0.45),
                    child: ListView(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Credit/Debit cards",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Image.asset(
                              "assets/images/visa.png",
                              width: 32,
                            ),
                            title: const Text("*************5085"),
                            trailing: const Text("EXP: 12/26"),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Image.asset(
                              "assets/images/visa.png",
                              width: 32,
                            ),
                            title: const Text("*************5085"),
                            trailing: const Text("EXP: 12/26"),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "E-Wallets",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Image.asset(
                              "assets/images/paypal.png",
                              width: 32,
                            ),
                            title: const Text("*************5085"),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Image.asset(
                              "assets/images/alipay.png",
                              width: 32,
                            ),
                            title: const Text("*************5085"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Center(
                        child: Text(
                          "Add a payment method",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.grey),
                        ),
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsetsDirectional.symmetric(vertical: 5),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 7,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),

                        /// make appointment successfully
                        onPressed: () => _makeAppointment(context),
                        child: const Padding(
                          padding: EdgeInsetsDirectional.symmetric(vertical: 5),
                          child: Text(
                            "Confirm",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
