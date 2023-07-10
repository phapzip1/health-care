import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/widgets/card_appointment_doctor.dart';
import 'package:health_care/widgets/schedule_screen/header.dart';
import 'package:intl/intl.dart';

class DoctorSection extends StatefulWidget {
  const DoctorSection({super.key, required this.list});
  final List<List<AppointmentModel>> list;
  @override
  State<DoctorSection> createState() => _DoctorSectionState();
}

class _DoctorSectionState extends State<DoctorSection> {
  bool _changedPage = true;

  void _click(value) {
    setState(() {
      _changedPage = value;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<AppBloc>().add(const AppEventLoadAppointments());
  }

  @override
  Widget build(BuildContext context) {
    final filterList = _changedPage ? widget.list[0] : widget.list[1];
    return Column(
      children: [
        Header(_click, _changedPage),
        Expanded(
          child: filterList.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: Image(image: AssetImage('assets/images/waiting.png')))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filterList.length,
                  itemBuilder: (ctx, index) {
                    String time =
                        DateFormat.Hm().format(filterList[index].datetime);
                    return CardAppointmentDoctor(
                      _changedPage,
                      MediaQuery.of(context).size,
                      filterList[index],
                      time,
                    );
                  },
                ),
        ),
      ],
    );
  }
}
