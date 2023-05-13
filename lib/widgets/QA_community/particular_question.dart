import 'package:flutter/material.dart';
import 'package:health_care/screens/communityQA.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ParticularQuestion extends StatelessWidget {
  const ParticularQuestion(this.question, {super.key});
  final QuestionCard question;

  Widget questionSection(question) => Padding(
        padding:
            const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 26.0,
                backgroundImage: AssetImage('assets/images/avatartUser.jpg'),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.gender + ", " + question.age.toString() + " aged",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    question.date,
                    style: TextStyle(color: Color(0xFF828282)),
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
          Text(question.mainContext),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: BoxDecoration(
                color: Color(0xFFAEE6FF).withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              question.relativeField,
              style: TextStyle(
                  color: Color(0xFF3A86FF), fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFFAEE6FF).withOpacity(0.5),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24.0,
                  backgroundImage: AssetImage('assets/images/avatartUser.jpg'),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Answered by'),
                    Text(
                      question.doctorAnswered,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          'Question',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          questionSection(question),
          const Divider(
            color: Colors.black,
            thickness: 0.3,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, right: 16, left: 16, bottom: 16),
            child: Column(children: [
              const Text(
                '16:01 20/04/2023',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF828282),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ...question.messageDoctor.map(
                (e) => Container(
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.only(bottom: 4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  child: Text(e),
                ),
              ),
              const SizedBox(height: 16,),
              ...question.messagePatient.map(
                (e) => Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFAEE6FF),
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  child: Text(e),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
