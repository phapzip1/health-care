import 'package:flutter/material.dart';
import 'package:health_care/models/post_model.dart';
import 'package:health_care/widgets/QA_community/particular_question.dart';
import 'package:intl/intl.dart';

class QuestionCard extends StatelessWidget {
  PostModel question;
  BuildContext context;
  QuestionCard(this.question, this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    String gender = question.gender == 0
        ? "Male"
        : question.gender == 1
            ? "Female"
            : "Other";

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ParticularQuestion(question)));
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
        ),
        padding: const EdgeInsets.all(16),
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
          question.doctorId != ""
              ? Column(children: [
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
                  const SizedBox(
                    height: 16,
                  ),
                ])
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                    color: const Color(0xFFFFE6A1).withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Text(
                  question.specialization,
                  style: const TextStyle(
                      color: Color(0xFFFFBE0B), fontWeight: FontWeight.w600),
                ),
              ),
              // Row(
              //   children: [
              //     const Icon(FontAwesomeIcons.comment),
              //     const SizedBox(
              //       width: 4,
              //     ),
              //     FutureBuilder(
              //       future: PostModel.getTotalChat(question.id!),
              //       builder: (ctx, comment) {
              //         if (comment.connectionState == ConnectionState.waiting) {
              //           return const CircularProgressIndicator();
              //         }
              //         return Text(comment.data.toString());
              //       },
              //     )
              //   ],
              // ),
            ],
          ),
        ]),
      ),
    );
  }
}
