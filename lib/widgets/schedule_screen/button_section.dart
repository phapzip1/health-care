import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonSchedule extends StatefulWidget {
  ButtonSchedule(this.changedPage, this.status, this.mediaQuery,
      this.updateStatus, this.appointmentId,
      {super.key});

  bool changedPage;
  int status;
  Size mediaQuery;
  String appointmentId;
  Function updateStatus;

  @override
  State<ButtonSchedule> createState() => _ButtonScheduleState();
}

class _ButtonScheduleState extends State<ButtonSchedule> {
  @override
  Widget build(BuildContext context) {
    return widget.changedPage
        ? Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              widget.status == 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFBE0B),
                                elevation: 0,
                                padding: EdgeInsets.symmetric(
                                    horizontal: widget.mediaQuery.width * 0.1)),
                            onPressed: () {},
                            child: const Text(
                              'Postpone',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16),
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2F80ED),
                                elevation: 0,
                                padding: EdgeInsets.symmetric(
                                    horizontal: widget.mediaQuery.width * 0.1)),
                            onPressed: () {},
                            child: const Text(
                              'Make a call',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16),
                            )),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE0E0E0),
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                  horizontal: widget.mediaQuery.width * 0.1)),
                          onPressed: () =>
                              widget.updateStatus(widget.appointmentId, 0),
                          child: const Text(
                            'Reject',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3A86FF),
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                  horizontal: widget.mediaQuery.width * 0.1)),
                          onPressed: () =>
                              widget.updateStatus(widget.appointmentId, 1),
                          child: const Text(
                            'Confirm',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
            ],
          )
        : Container();
  }
}
