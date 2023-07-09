import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeChoosing extends StatefulWidget {
  final List<DateTime> time;
  final Size mediaQuery;
  final void Function(DateTime? date) onChange;

  const TimeChoosing({
    super.key,
    required this.time,
    required this.mediaQuery,
    required this.onChange,
  });

  @override
  State<TimeChoosing> createState() => _TimeChoosingState();
}

class _TimeChoosingState extends State<TimeChoosing> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = -1;
  }

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
            final datetime = widget.time[index];
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
                color: index == _selectedIndex ? const Color(0xFFC4FAFF) : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: InkWell(
                onTap: () {
                  if (index != _selectedIndex) {
                    setState(() {
                      _selectedIndex = index;
                    });
                    widget.onChange(widget.time[index]);
                  } else {
                    setState(() {
                      _selectedIndex = -1;
                    });
                    widget.onChange(null);
                  }
                },
                child: Center(child: Text(DateFormat.Hm().format(datetime))),
              ),
            );
          }),
    );
  }
}
