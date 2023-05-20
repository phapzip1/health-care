import "package:flutter/material.dart";

class WeekdayRadio extends StatefulWidget {
  WeekdayRadio({super.key, this.onDayChange});
  Function(DateTime day)? onDayChange;

  @override
  State<WeekdayRadio> createState() => _WeekdayRadioState();
}

class _WeekdayRadioState extends State<WeekdayRadio> {
  DateTime selected = DateTime.now();

  bool _compareDate(DateTime date1, DateTime date2) => date1.day == date2.day && date1.month == date2.month && date1.year == date2.year;

  @override
  Widget build(BuildContext context) {
    const calendarTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);
    final now = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ...["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"].asMap().entries.map(
          (e) {
            final dayDiff = now.weekday - (e.key + 1);

            DateTime currentIndex = now;

            if (dayDiff > 0) {
              currentIndex = now.subtract(Duration(days: dayDiff));
            } else if (dayDiff < 0) {
              currentIndex = now.add(Duration(days: dayDiff));
            }
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(45, 12),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
                elevation: 0,
                backgroundColor:  _compareDate(currentIndex, selected) ? const Color(0xFF3A86FF) : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                if (dayDiff != 0) {
                  setState(() {
                    selected = currentIndex;
                  });
                  if (widget.onDayChange != null) {
                    widget.onDayChange!(currentIndex);
                  }
                }
              },
              child: Column(
                children: <Widget>[
                  Text(
                    currentIndex.day.toString(),
                    style: calendarTextStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    e.value,
                    style: calendarTextStyle,
                  ),
                ],
              ),
            );
          },
        ).toList(),
      ],
    );
  }
}
