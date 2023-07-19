import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/models/post_model.dart';
import 'package:health_care/widgets/QA_community/question_section.dart';
import 'package:health_care/widgets/chat/messages.dart';
import 'package:health_care/widgets/chat/new_message.dart';

class ParticularQuestion extends StatelessWidget {
  const ParticularQuestion(this.question, {super.key});
  final PostModel question;

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
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
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.49,
              ),
              child: Column(
                children: [
                  QuestionSection(question),
                  const Divider(
                    color: Colors.black,
                    thickness: 0.3,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Messages(
                      post: question,
                    ),
                  ),
                  BlocBuilder<AppBloc, AppState>(
                    builder: (context, state) =>
                        (question.patientId == userId || state.doctor != null)
                            ? NewMessage(post: question)
                            : Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
