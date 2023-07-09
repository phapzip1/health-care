import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:intl/intl.dart';

class PersonalAppointment extends StatelessWidget {
  const PersonalAppointment({super.key});

  Widget build(BuildContext context) {
    context.read<AppBloc>().add(const AppEventLoadAppointments());
    return BlocBuilder<AppBloc, AppState>(
        // future: AppointmentModel.getAppointment(patientId: user!.uid),
        builder: (ctx, state) {
      if (state.appointments == null) {
        return const Center(child: CircularProgressIndicator());
      }
      final appointmentDocs = state.appointments![0];

      return appointmentDocs.isEmpty
          ? const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'There are no appointments',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(Icons.not_accessible_outlined),
                ],
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: appointmentDocs.length,
              itemBuilder: (ctx, index) {
                return Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFC9C9C9),
                        blurRadius: 1,
                        spreadRadius: 1,
                      ),
                    ],
                    color: Color(0xFFAEE6FF),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: IntrinsicWidth(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 28.0,
                                backgroundImage: NetworkImage(appointmentDocs[index].doctorImage),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appointmentDocs[index].doctorName,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    appointmentDocs[index].specialization,
                                    style: const TextStyle(color: Color(0xFF828282), fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.clock,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(DateFormat('dd-MM-y').format(appointmentDocs[index].datetime)),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(DateFormat.Hm().format(appointmentDocs[index].datetime))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
    });
  }
}
