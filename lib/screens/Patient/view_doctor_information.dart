import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/screens/Patient/payment_screen.dart';
import 'package:health_care/screens/general/review_section.dart';
import 'package:health_care/widgets/infomation_page/time_choosing.dart';
import 'package:health_care/widgets/infomation_page/upper_part.dart';
import 'package:intl/intl.dart';

class ViewDoctorInformation extends StatefulWidget {
  final DoctorModel userDocs;
  const ViewDoctorInformation(this.userDocs, {super.key});

  @override
  State<ViewDoctorInformation> createState() => _ViewDoctorInformationState();
}

class _ViewDoctorInformationState extends State<ViewDoctorInformation> {
  late DateTime _selectedDate;
  late DateTime? _meetingTime;

  _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: now,
      lastDate: now.add(
        const Duration(days: 7),
      ),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    context
        .read<AppBloc>()
        .add(AppEventLoadAvailableTime(_selectedDate, widget.userDocs.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Doctor Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          UpperPart(widget.userDocs),
          const SizedBox(
            height: 8,
          ),
          Card(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About doctor',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Year of experience',
                            style: TextStyle(),
                          ),
                          Text(
                            '${widget.userDocs.experience} years',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      // ignore: prefer_const_constructors
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Patients checked',
                            style: TextStyle(),
                          ),
                          FutureBuilder(
                            future: context
                                .read<AppBloc>()
                                .appointmentProvider
                                .getCompletedAppointmentCount(
                                    widget.userDocs.id),
                            builder: (ctx, total) {
                              if (total.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              return Text(
                                total.data.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Schedules',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          primary: Colors.black,
                          textStyle: const TextStyle(fontSize: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('dd/MM/y').format(_selectedDate),
                              ),
                              const Icon(
                                FontAwesomeIcons.calendar,
                                color: Colors.black,
                              ),
                            ]),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Time available',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    if (state.availableTime == null) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state.availableTime!.isEmpty) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: const Text('There is no time frame available'),
                      );
                    }
                    return TimeChoosing(
                      time: state.availableTime!,
                      mediaQuery: MediaQuery.of(context).size,
                      onChange: (date) {
                        _meetingTime = date;
                      },
                    );
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  onPressed: () {
                    _meetingTime == null
                        ? Fluttertoast.showToast(
                            msg: "You must choose time",
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          )
                        : Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<AppBloc>(context),
                                child: PaymentScreen(
                                  widget.userDocs.id,
                                  widget.userDocs.name,
                                  widget.userDocs.price.truncate(),
                                  widget.userDocs.phoneNumber,
                                  widget.userDocs.image,
                                  widget.userDocs.specialization,
                                  _meetingTime!,
                                ),
                              ),
                            ),
                          );
                  },
                  child: const Text(
                    'Make appointment',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  // ignore: prefer_const_constructors
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Reviews',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ReviewSection(widget.userDocs),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
