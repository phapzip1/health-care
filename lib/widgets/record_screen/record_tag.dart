import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/models/health_record_model.dart';
import 'package:health_care/widgets/record_screen/record_detail.dart';
// import 'package:health_care/models/health_record_model.dart';
import 'package:intl/intl.dart';

class RecordTag extends StatelessWidget {
  final HealthRecordModel record;
  final AppointmentModel healthRecord;
  final bool isDoctor;
  const RecordTag(this.record, this.healthRecord, this.isDoctor, {super.key});

  @override
  Widget build(BuildContext context) {
    final _time = DateFormat('dd-MM-y').format(healthRecord.datetime);
    final _hour = DateFormat.Hm().format(healthRecord.datetime);

    return InkWell(
      onTap: () {
        // NavigationService.navKey.currentState?.pushNamed('/record',
        //     arguments: {"record": healthRecord, "isDoctor": isDoctor});
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                      value: BlocProvider.of<AppBloc>(context),
                      child: RecordDetail(record, isDoctor, healthRecord),
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
                Text('Time: ${_time}  ${_hour}'),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
