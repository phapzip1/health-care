import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/services/navigation_service.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AppointmentDetailForDoctor extends StatefulWidget {
  AppointmentModel appointment;
  Function updateStatus;

  AppointmentDetailForDoctor(this.appointment, this.updateStatus, {super.key});

  @override
  State<AppointmentDetailForDoctor> createState() =>
      _AppointmentDetailForDoctorState();
}

class _AppointmentDetailForDoctorState
    extends State<AppointmentDetailForDoctor> {
  bool isConfirm = false;

  @override
  void initState() {
    isConfirm = widget.appointment.status == 1;
    super.initState();
  }

  void _updateState(int status) {
    widget.updateStatus(widget.appointment.id!, status);

    setState(() {
      isConfirm = status == 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double listtileVerticalPadding = 4.5;
    final _time = DateFormat('dd-MM-y').format(widget.appointment.dateTime);
    final _hour = DateFormat.Hm().format(widget.appointment.dateTime);
    final now = DateTime.now();
    final meeting = DateTime(
      widget.appointment.dateTime.year,
      widget.appointment.dateTime.month,
      widget.appointment.dateTime.day,
      (widget.appointment.meetingTime / 10).truncate(),
      (widget.appointment.meetingTime % 10) * 10,
    );
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Confirm Appointment",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(
                                      widget.appointment.patientImage),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.35),
                                  child: Text(
                                    widget.appointment.patientName,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    overflow: TextOverflow.clip,
                                    softWrap: true,
                                  ),
                                ),
                                const VerticalDivider(
                                  width: 16,
                                  thickness: 1.5,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2F80ED),
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 12)),
                                onPressed: () {},
                                child: const Row(
                                  children: [
                                    Icon(Icons.upload),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Write record',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                          leading: const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Icon(
                              FontAwesomeIcons.person,
                              color: Colors.yellow,
                              size: 32,
                            ),
                          ),
                          title: const Text(
                            "Patient",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          subtitle: Text(
                            widget.appointment.patientName,
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
                          // subtitle: Text(
                          //   "$price vnd",
                          //   style: const TextStyle(
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.black),
                          // ),
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
                          title: const Text(
                            "Time",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          subtitle: Text(
                            "$_time    $_hour",
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
                          leading: const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Icon(
                              FontAwesomeIcons.exclamation,
                              color: Colors.yellow,
                              size: 32,
                            ),
                          ),
                          title: const Text(
                            "Issue",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          subtitle: Text(
                            widget.appointment.specialization,
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
                          leading: const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Icon(
                              Icons.check_circle_outline,
                              color: Colors.yellow,
                              size: 30,
                            ),
                          ),
                          title: const Text(
                            "Status",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          subtitle: Text(
                            widget.appointment.status == 0
                                ? "Waiting"
                                : widget.appointment.status == 1
                                    ? "Confirmed"
                                    : "Rejected",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      isConfirm
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (now.isBefore(meeting
                                    .subtract(const Duration(minutes: 30))))
                                  SizedBox(
                                    width: mediaQuery.width * 0.5,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFFFBE0B),
                                            elevation: 0,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    mediaQuery.width * 0.05,
                                                vertical: 12)),
                                        onPressed: () {
                                          widget.appointment.cancel();
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 16),
                                        )),
                                  ),
                                if (now.isBefore(meeting
                                    .subtract(const Duration(minutes: 5))))
                                  SizedBox(
                                    width: mediaQuery.width * 0.5,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF2F80ED),
                                          elevation: 0,
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  mediaQuery.width * 0.05,
                                              vertical: 12)),
                                      onPressed: () {
                                        NavigationService.navKey.currentState
                                            ?.pushNamed('/chat',
                                                arguments: widget.appointment);
                                      },
                                      child: const Text(
                                        'Send message',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: mediaQuery.width * 0.5,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFE0E0E0),
                                        elevation: 0,
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                mediaQuery.width * 0.1)),
                                    onPressed: () => _updateState(2),
                                    child: const Text(
                                      'Reject',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: mediaQuery.width * 0.5,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF3A86FF),
                                        elevation: 0,
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                mediaQuery.width * 0.1)),
                                    onPressed: () => _updateState(1),
                                    child: const Text(
                                      'Confirm',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16),
                                    ),
                                  ),
                                )
                              ],
                            ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}