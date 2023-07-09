import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
import 'package:health_care/bloc/app_state.dart';
import 'package:health_care/models/post_model.dart';
import 'package:health_care/screens/general/filiter_symptom.dart';
import 'package:health_care/widgets/QA_community/header_navigate_section.dart';
import 'package:health_care/widgets/QA_community/input_question_modal.dart';
import 'package:health_care/widgets/QA_community/question_card.dart';
import 'package:intl/intl.dart';

class CommunityQA extends StatefulWidget {
  const CommunityQA({super.key});

  @override
  State<CommunityQA> createState() => _CommunityQAState();
}

class _CommunityQAState extends State<CommunityQA> {
  final String formattedDate = DateFormat.yMd().format(DateTime.now());
  bool _changedPage = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<AppBloc>().add(const AppEventLoadPosts(null));
  }

  void _openFilterSymptom(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: const FilterSymptom(),
        );
      },
    );
  }

  void _click(value) {
    setState(() {
      _changedPage = value;
    });
  }

  Widget _buildListAll(List<PostModel> socialPost) {
    return Expanded(
      child: ListView.builder(
        itemCount: socialPost.length,
        itemBuilder: (context, index) {
          return QuestionCard(socialPost[index], context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Q&A community',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Column(
        children: [
          HeaderNavigateSection(_click, _changedPage, mediaQuery, context,
              _searchController, _openFilterSymptom),
          BlocBuilder<AppBloc, AppState>(builder: (context, state) {
            if (state.posts == null) {
              return Container();
            }
            return _buildListAll(state.posts!);
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3A86FF),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<AppBloc>(context),
                      child: const InputQuestionModal(),
                    )),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
