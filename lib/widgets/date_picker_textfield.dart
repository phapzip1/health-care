import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerTextField extends StatefulWidget {
  final void Function(DateTime value) onChange;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  const DatePickerTextField({super.key, required this.onChange, required this.initialDate, required this.firstDate, required this.lastDate});

  @override
  State<DatePickerTextField> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  late DateTime _pickedDate;

  @override
  void initState() {
    super.initState();
    _pickedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditingController(
        text: DateFormat('dd/MM/y').format(_pickedDate),
      ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3A86FF))),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
      readOnly: true,
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: widget.initialDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
        );

        if (pickedDate != null && pickedDate != _pickedDate) {
          _pickedDate = pickedDate;
          widget.onChange(_pickedDate);
        }
      },
    );
  }
}
