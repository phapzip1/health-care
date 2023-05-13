import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/widgets/button_section.dart';
import 'package:health_care/widgets/QA_community/particular_question.dart';
import 'package:intl/intl.dart';

class CommunityQA extends StatefulWidget {
  const CommunityQA({super.key});

  @override
  State<CommunityQA> createState() => _CommunityQAState();
}

final TextEditingController _searchController = TextEditingController();

Widget headerNavigateSection(click, changedPage, mediaQuery) => Padding(
      padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ButtonSection(
            click: click,
            status: changedPage,
            mediaQuery: mediaQuery,
            sampleData: [
              RadioModel(true, "All", 0),
              RadioModel(false, "Your Question", 1)
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 24,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _searchController.clear(),
                ),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Perform the search here
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );

class QuestionCard {
  final String gender;
  final int age;
  final String date;
  final String mainContext;
  final String doctorAnswered;
  final String relativeField;
  final List<String> messageDoctor;
  final List<String> messagePatient;

  QuestionCard(
      this.gender,
      this.age,
      this.date,
      this.mainContext,
      this.doctorAnswered,
      this.relativeField,
      this.messageDoctor,
      this.messagePatient);
}

final String formattedDate = DateFormat.yMd().format(DateTime.now());

final List<QuestionCard> questions = [
  QuestionCard(
      'Man',
      32,
      formattedDate,
      'mainContextmainContextmainContextmainContextmainContextmainContext',
      'Dr.Anna Baker',
      'Heart surgeon specialist',
      ['Text Text Text Text Text Text', 'Text Text Text Text Text'],
      ['Text Text Text Text Text', 'Text', 'Text Text']),
  QuestionCard(
      'Woman',
      24,
      formattedDate,
      'mainContextmainContextmainContextmainContextmainContextmainContext',
      'Dr.Anna Baker',
      'Heart surgeon specialist',
      ['Text Text Text Text Text Text', 'Text Text Text Text Text'],
      ['Text Text Text Text Text', 'Text', 'Text Text']),
  QuestionCard(
      'Man',
      28,
      formattedDate,
      'mainContextmainContextmainContextmainContextmainContextmainContext',
      'Dr.Anna Baker',
      'Heart surgeon specialist',
      ['Text Text Text Text Text Text', 'Text Text Text Text Text'],
      ['Text Text Text Text Text', 'Text', 'Text Text']),
];

Widget questionCard(question, context) => InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ParticularQuestion(question)));
      },
      child: Container(
        margin: EdgeInsets.only(top: 16),
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
        padding: EdgeInsets.all(16),
        child: Column(children: [
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
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              Row(
                children: [
                  Icon(FontAwesomeIcons.comment),
                  const SizedBox(
                    width: 4,
                  ),
                  Text((question.messageDoctor.length +
                          question.messagePatient.length)
                      .toString())
                ],
              ),
            ],
          ),
        ]),
      ),
    );

class _CommunityQAState extends State<CommunityQA> {
  bool _changedPage = true;

  void _click(value) {
    setState(() {
      _changedPage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Q&A community',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          headerNavigateSection(_click, _changedPage, mediaQuery),
          _changedPage
              ? Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: questions.length,
                    itemBuilder: (context, index) =>
                        questionCard(questions[index], context),
                  ),
                )
              : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF3A86FF),
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
