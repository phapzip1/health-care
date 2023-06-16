import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/services/navigation_service.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CardAppointmentDoctor extends StatefulWidget {
  CardAppointmentDoctor(this.changedPage, this.mediaQuery, this.schedule, this.time, this.updateStatus, {super.key});

  bool changedPage;
  Size mediaQuery;
  AppointmentModel schedule;
  String time;
  Function updateStatus;

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

  void _updateState(int status) {
    widget.updateStatus(widget.schedule.id!, status);

    setState(() {
      isConfirm = status == 1;
    });
  }

  void _makeCall() async {
    await widget.schedule
        .makeCall()
        .then((value) => NavigationService.navKey.currentState?.pushNamed('/call', arguments: {
              'token': value,
              'channelId': widget.schedule.id,
              'remotename': widget.schedule.patientName,
              'remotecover': widget.schedule.patientName,
              'caller': true,
            }))
        .catchError((error, stackTrace) {
      Fluttertoast.showToast(
        msg: "An error occurred",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Column(
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
                        style: const TextStyle(fontSize: 16, color: Color(0xFF828282)),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        widget.schedule.patientPhone,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 26.0,
                  backgroundImage: NetworkImage(widget.schedule.patientImage),
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
                      DateFormat('dd-MM-y').format(widget.schedule.dateTime),
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
                            backgroundColor: widget.schedule.status == 0 ? const Color(0xFFE2B93B) : const Color(0xFFEB5757),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            widget.schedule.status == 0 ? "Waiting" : "Rejected",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      )
                    : const Row(children: [
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
                      ]),
              ],
            ),
            widget.changedPage
                ? Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      isConfirm
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFFFBE0B), elevation: 0, padding: EdgeInsets.symmetric(horizontal: widget.mediaQuery.width * 0.1, vertical: 12)),
                                    onPressed: () {},
                                    child: const Text(
                                      'Postpone',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
                                    )),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF2F80ED), elevation: 0, padding: EdgeInsets.symmetric(horizontal: widget.mediaQuery.width * 0.1, vertical: 12)),
                                    onPressed: _makeCall,
                                    child: const Text(
                                      'Make a call',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                                    )),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE0E0E0), elevation: 0, padding: EdgeInsets.symmetric(horizontal: widget.mediaQuery.width * 0.1)),
                                  onPressed: () => _updateState(2),
                                  child: const Text(
                                    'Reject',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3A86FF), elevation: 0, padding: EdgeInsets.symmetric(horizontal: widget.mediaQuery.width * 0.1)),
                                  onPressed: () => _updateState(1),
                                  child: const Text(
                                    'Confirm',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
    ;
  }
}
