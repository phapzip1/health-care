import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/screens/general/appointment_detail_for_doctor.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CardAppointmentDoctor extends StatefulWidget {
  CardAppointmentDoctor(
    this.changedPage,
    this.mediaQuery,
    this.schedule,
    this.time, {
    super.key,
  });

  bool changedPage;
  Size mediaQuery;
  AppointmentModel schedule;
  String time;

  @override
  State<CardAppointmentDoctor> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CardAppointmentDoctor> {
  bool isConfirm = false;

  @override
  void initState() {
    isConfirm = widget.schedule.status == 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<AppBloc>(context),
            child: AppointmentDetailForDoctor(
              widget.schedule,
            ),
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<AppBloc, AppState>(
            builder: (ctx, state) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.schedule.patientName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Issues: ${widget.schedule.specialization}",
                              style: const TextStyle(
                                  fontSize: 16, color: Color(0xFF828282)),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              widget.schedule.patientPhone,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 26.0,
                        backgroundImage:
                            NetworkImage(widget.schedule.patientImage),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.calendar,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            DateFormat('dd-MM-y')
                                .format(widget.schedule.datetime),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.clock,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            widget.time,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      !isConfirm
                          ? Row(
                              children: [
                                CircleAvatar(
                                  radius: 4,
                                  backgroundColor: widget.schedule.status == 0
                                      ? const Color(0xFFE2B93B)
                                      : const Color(0xFFEB5757),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  widget.schedule.status == 0
                                      ? "Waiting"
                                      : "Rejected",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            )
                          : const Row(
                              children: [
                                CircleAvatar(
                                  radius: 4,
                                  backgroundColor: Color(0xFF27AE60),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Confirmed",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
