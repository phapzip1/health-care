import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TimeChoosing extends StatefulWidget {
  List<dynamic> time;
  Size mediaQuery;
  int day;
  int month;
  int year;
  Function onChange;
  bool isDoctor;
  TimeChoosing(this.time, this.mediaQuery, this.day, this.month, this.year,
      this.onChange, this.isDoctor,
      {super.key});

  @override
  State<TimeChoosing> createState() => _TimeChoosingState();
}

class _TimeChoosingState extends State<TimeChoosing> {
  int isChecked = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: widget.mediaQuery.width * 0.12,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.time.length,
          itemBuilder: (ctx, index) {
            return Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFC9C9C9),
                    blurRadius: 0.5,
                    spreadRadius: 0.5,
                  ),
                ],
                color:
                    index == isChecked ? const Color(0xFFC4FAFF) : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: InkWell(
                onTap: () {
                  widget.isDoctor
                      ? null
                      : setState(() {
                          if (isChecked == index) {
                            isChecked = -1;
                            widget.onChange(-1);
                          } else {
                            isChecked = index;
                            widget.onChange(widget.time[index]);
                          }
                        });
                },
                child: Center(
                    child: Text(widget.time[index] % 10 == 3
                        ? '${widget.time[index] ~/ 10}:30'
                        : '${widget.time[index] ~/ 10}:00')),
              ),
            );
          }),
    );
  }
}
