import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/models/post_model.dart';
import 'package:intl/intl.dart';

class QuestionSection extends StatelessWidget {
  final PostModel question;
  const QuestionSection(this.question, {super.key});

  @override
  Widget build(BuildContext context) {
    String gender = question.gender == 0
        ? "Male"
        : question.gender == 1
            ? "Female"
            : "Other";
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 26.0,
              backgroundImage: AssetImage('assets/images/avatartUser.png'),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$gender, ${question.age} aged",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat('dd/MM/y').format(question.time),
                  style: const TextStyle(color: Color(0xFF828282)),
                ),
              ],
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Text(question.description),
        const SizedBox(
          height: 16,
        ),

        //Check có phải doctor ko để có thể xem hình
        BlocBuilder<AppBloc, AppState>(
            builder: (context, state) => (state.doctor != null || question.patientId == userId)
                ? SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).width * 0.24,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: question.images.length,
                      itemBuilder: (context, index) => SizedBox(
                          child: Image(
                              image: NetworkImage(question.images[index]))),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 8,
                      ),
                    ),
                  )
                : Container()),

        const SizedBox(
          height: 16,
        ),

        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration: BoxDecoration(
              color: const Color(0xFFFFE6A1).withOpacity(0.5),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Text(
            question.specialization,
            style: const TextStyle(
                color: Color(0xFFFFBE0B), fontWeight: FontWeight.w600),
          ),
        ),
        question.doctorId != null
            ? Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: const Color(0xFFAEE6FF).withOpacity(0.5),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24.0,
                          backgroundImage: NetworkImage(question.doctorImage!),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Answered by'),
                            Text(
                              question.doctorName!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container()
      ]),
    );
  }
}
