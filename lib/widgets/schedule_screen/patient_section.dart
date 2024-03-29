import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/screens/general/appointment_detail_for_patient.dart';
import 'package:health_care/widgets/schedule_screen/header.dart';

class PatientSection extends StatefulWidget {
  const PatientSection(this.scheduleDocs, {super.key});

  final List<List<AppointmentModel>> scheduleDocs;

  @override
  State<PatientSection> createState() => _PatientSectionState();
}

class _PatientSectionState extends State<PatientSection> {
  bool _changedPage = true;

  void _click(value) {
    setState(() {
      _changedPage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterList =
        _changedPage ? widget.scheduleDocs[0] : widget.scheduleDocs[1];
    return Column(
      children: [
        Header(_click, _changedPage),
        Expanded(
            child: filterList.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child:
                        Image(image: AssetImage('assets/images/waiting.png')))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filterList.length,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<AppBloc>(context),
                            child:
                                AppointmentDetailForPatient(filterList[index]),
                          ),
                        )),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8.0, top: 8.0),
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
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            filterList[index].doctorName,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            filterList[index].specialization,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF828282)),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            filterList[index].doctorPhone,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 26.0,
                                      backgroundImage: NetworkImage(
                                          filterList[index].doctorImage),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          filterList[index]
                                              .datetime
                                              .toString()
                                              .substring(0, 10),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
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
                                          filterList[index]
                                              .datetime
                                              .toString()
                                              .substring(10, 16),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 4,
                                          backgroundColor:
                                              filterList[index].status == 0
                                                  ? const Color(0xFFE2B93B)
                                                  : const Color(0xFF27AE60),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          filterList[index].status == 0
                                              ? "Waiting"
                                              : filterList[index].status == 1
                                                  ? "Confirmed"
                                                  : "Rejected",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
      ],
    );
  }
}
