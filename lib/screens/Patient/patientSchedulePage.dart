import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_state.dart';

import 'package:health_care/widgets/schedule_screen/patient_section.dart';

class PatientSchedulePage extends StatelessWidget {
  const PatientSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return PatientSection(state.appointments!);
      },
    ));
  }
}
