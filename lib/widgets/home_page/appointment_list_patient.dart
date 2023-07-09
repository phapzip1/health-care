import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/screens/Patient/view_doctor_information.dart';

class AppointmentListPatient extends StatelessWidget {
  const AppointmentListPatient({super.key, required this.spec});

  final String spec;

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      final doctors = state.doctors ?? [];
      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: doctors.length,
          itemBuilder: (ctx, index) {
            return Container(
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
              child: InkWell(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<AppBloc>(context),
                        child: ViewDoctorInformation(doctors[index]),
                      ),
                    ),
                  )
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            image: NetworkImage(state.doctors![index].image),
                            height: 80,
                            width: 64,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctors[index].name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                doctors[index].specialization,
                                style: const TextStyle(fontSize: 16, color: Color(0xFF828282)),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.solidStar,
                                        color: Colors.yellow,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text("${doctors[index].rating}"),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Consultation price:',
                          style: TextStyle(fontSize: 16, color: Color(0xFF828282)),
                        ),
                        Text("${state.doctors![index].price.truncate()} vnd", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ]),
                ),
              ),
            );
          });
    });
  }
}
