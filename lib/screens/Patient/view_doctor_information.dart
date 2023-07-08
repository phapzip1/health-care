import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/screens/Patient/payment_screen.dart';
import 'package:intl/intl.dart';

class ViewDoctorInformation extends StatefulWidget {
  final DoctorModel userDocs;
  const ViewDoctorInformation(this.userDocs, {super.key});

  @override
  State<ViewDoctorInformation> createState() => _ViewDoctorInformationState();
}

class _ViewDoctorInformationState extends State<ViewDoctorInformation> {
  late DateTime _selectedDate;

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
    context.read<AppBloc>().add(AppEventLoadAvailableTime(_selectedDate));
  }

  int _choosingTime = -1;

  void _onChange(index) {
    _choosingTime = index;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          onPressed: () {
            _selectDate(context);
          },
          style: OutlinedButton.styleFrom(
            primary: Colors.black,
            textStyle: const TextStyle(fontSize: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(DateFormat('dd/MM/y').format(_selectedDate)),
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
        // FutureBuilder(
        //     future: userDocs.checkTime(),
        //     builder: (ctx, futureCheck) {
        //       if (futureCheck.connectionState ==
        //           ConnectionState.waiting) {
        //         return const Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }
        //       if (futureCheck.data!) {
        //         return ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //             padding: const EdgeInsets.symmetric(
        //                 horizontal: 16, vertical: 12),
        //           ),
        //           onPressed: () {
        //             NavigationService.navKey.currentState
        //                 ?.pushNamed('/schedule',
        //                     arguments: userDocs.id);
        //           },
        //           child: const Text(
        //             'Choose your time for consultant',
        //             style: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 16),
        //           ),
        //         );
        //       }

        //       return FutureBuilder(
        //           future: userDocs.getAvailableTime(
        //             _selectedDate.day,
        //             _selectedDate.month,
        //             _selectedDate.year,
        //           ),
        //           builder: (ctx, future) {
        //             if (future.connectionState ==
        //                 ConnectionState.waiting) {
        //               return const Center(
        //                 child: CircularProgressIndicator(),
        //               );
        //             }
        //             final time = future.data!;
        //             return time.isEmpty
        //                 ? const Text(
        //                     'There is no time frame available')
        //                 : TimeChoosing(
        //                     time,
        //                     mediaQuery,
        //                     _selectedDate.day,
        //                     _selectedDate.month,
        //                     _selectedDate.year,
        //                     _onChange,
        //                     widget.isDoctor);
        //           });
        //     }),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onPressed: () {
              //payment screen
              _choosingTime == -1
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
                              _selectedDate,
                              _choosingTime),
                        ),
                      ),
                    );
            },
            child: const Text(
              'Make appointment',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
      ],
    );
  }
}
