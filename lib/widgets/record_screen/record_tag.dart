import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/widgets/record_screen/record_detail.dart';
import 'package:intl/intl.dart';

class RecordTag extends StatelessWidget {
  final AppointmentModel healthRecord;
  final bool isDoctor;
  const RecordTag(this.healthRecord, this.isDoctor, {super.key});

  @override
  Widget build(BuildContext context) {
    final meeting = healthRecord.datetime;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<AppBloc>(context),
                    child: RecordDetail(isDoctor, healthRecord),
                  )),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFFC9C9C9),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(16),
        child: IntrinsicHeight(
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                image: NetworkImage(isDoctor
                    ? healthRecord.patientImage
                    : healthRecord.doctorImage),
                height: 80,
                width: 64,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isDoctor ? healthRecord.patientName : healthRecord.doctorName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    'Time: ${DateFormat.yMd().add_Hm().format(meeting)}'),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
