import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/widgets/schedule_screen/doctor_section.dart';

class DoctorSchedulePage extends StatelessWidget {
  const DoctorSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) => DoctorSection(list: state.appointments!),
      ),
    );
  }
}
