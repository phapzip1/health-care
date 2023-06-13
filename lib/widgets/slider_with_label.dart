import 'package:flutter/material.dart';

class SliderWithLabel extends StatelessWidget {
  const SliderWithLabel({
    super.key,
    required this.label,
    required this.onChanged,
    required this.value,
    required this.timeText,
  });

  final Function(double value) onChanged;
  final double value;
  final String label;
  final String timeText;

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 15);
    const timeStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 20);

    return Column(
      children: <Widget>[
        Text(
          label,
          style: labelStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          timeText,
          style: timeStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Slider(min: 0, max: 8, value: value, divisions: 8, onChanged: onChanged),
      ],
    );
  }
}
