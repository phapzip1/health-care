import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/widgets/record_screen/record_tag.dart';

class PatientRecords extends StatelessWidget {
  final bool isDoctor;
  const PatientRecords(this.isDoctor, {super.key});

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Records',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<AppBloc, AppState>(
            // future: widget.isDoctor
            //     ? HealthRecordModel.get(doctorId: user!.uid)
            //     : HealthRecordModel.get(patientId: user!.uid),
            builder: (ctx, state) {
              widget.isDoctor ? state.doctor.
              return ListView.builder(
                  itemCount: healthRecord.length,
                  itemBuilder: (ctx, index) =>
                      RecordTag(healthRecord[index], widget.isDoctor));
            },
          ),
        ));
  }
}
