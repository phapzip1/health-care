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

    context.read<AppBloc>().add(const AppEventLoadPosts('All'));
  }

  void _openFilterSymptom(symptom) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: FilterSymptom(symptom, _getPosts),
        );
      },
    );
  }

  void _getPosts(String name) {
    context.read<AppBloc>().add(AppEventLoadPosts(name));
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
          return QuestionCard(socialPost[index]);
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
      body: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
        final posts = state.posts ?? [];
        return Column(
          children: [
            HeaderNavigateSection(
              _click,
              _changedPage,
              mediaQuery,
              _searchController,
              _openFilterSymptom,
              state.symptom ?? [],
            ),
            _buildListAll(posts),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3A86FF),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<AppBloc>(context),
                    child: const InputQuestionModal(),
                  )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
