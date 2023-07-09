import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:intl/intl.dart';

class AppointmentListDoctor extends StatelessWidget {
  const AppointmentListDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AppBloc>().add(const AppEventLoadAppointments());
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state.appointments == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final doctors = state.appointments![0];

        return doctors.isEmpty
            ? Container(
                margin: const EdgeInsets.only(top: 16),
                child: const Center(
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
                ),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: doctors.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16),
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Color(0xFFC9C9C9),
                        blurRadius: 1,
                        spreadRadius: 0.8,
                      ),
                    ], color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                    // ignore: sort_child_properties_last
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 28.0,
                                backgroundImage: NetworkImage(doctors[index].patientImage),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctors[index].patientName,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.calendar,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              DateFormat('dd-MM-y').format(doctors[index].datetime),
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 32,
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.clock,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              DateFormat.Hm().format(doctors[index].datetime),
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Issues:',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                doctors[index].specialization,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
      },
    );
  }
}
