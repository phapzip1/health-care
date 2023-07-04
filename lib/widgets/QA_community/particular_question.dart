import 'package:flutter/material.dart';
import 'package:health_care/models/post_model.dart';
import 'package:intl/intl.dart';

class ParticularQuestion extends StatelessWidget {
  const ParticularQuestion(this.question, {super.key});
  final PostModel question;

  Widget questionSection(PostModel question) {
    String gender = question.gender == 0
        ? "Male"
        : question.gender == 1
            ? "Female"
            : "Other";

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
        question.doctorId != ""
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Question',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: questionSection(question),
      ),
    );
  }
}
