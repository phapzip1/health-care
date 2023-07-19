import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ReviewSection extends StatelessWidget {
  final DoctorModel userDocs;
  const ReviewSection(this.userDocs, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<AppBloc>().doctorProvider.getFeedbacks(userDocs.id),
        builder: (ctx, reviewSnapshot) {
          if (reviewSnapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (!reviewSnapshot.hasData) {
            return Container();
          }

          final reviews = reviewSnapshot.data!;

          return ListView.builder(
              shrinkWrap: true,
              itemCount: reviews.length,
              itemBuilder: (ctx, index) {
                double rating = reviews[index].rating;
                return Container(
                  padding: const EdgeInsets.all(16),
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 26.0,
                                backgroundImage: NetworkImage(
                                    reviews[index].patientImage)),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    reviews[index].patientName,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                Text(
                                  DateFormat('dd/MM/y')
                                      .format(reviews[index].createAt),
                                  style: const TextStyle(
                                      color: Color(0xFF666666), fontSize: 16),
                                )
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: Colors.yellow,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  rating.round().toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          reviews[index].message,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ]),
                );
              });
        });
  }
}
