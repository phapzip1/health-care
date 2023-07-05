import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  bool isLoading = false;
  bool _changedPage = true;
  List<PostModel> posts = [];
  ScrollController _controller = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _getMoreData("");
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getMoreData(posts[posts.length - 1].id);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openFilterSymptom(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: FilterSymptom(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _click(value) {
    setState(() {
      _changedPage = value;
      posts = [];
      _getMoreData("");
    });
  }

  void _getMoreData(String id) async {
    setState(() {
      isLoading = true;
    });

    final newPost = _changedPage
        ? await PostModel.getPublic(id)
        : await PostModel.getAsPatient(id, userId);

    setState(() {
      isLoading = false;
      posts.addAll(newPost);
    });
  }

  Widget _buildListAll(socialPost) {
    return Expanded(
      child: ListView.builder(
        itemCount: socialPost.length + 1,
        itemBuilder: (context, index) {
          if (index == socialPost.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Opacity(
                  opacity: isLoading ? 1.0 : 00,
                  child: const CircularProgressIndicator(),
                ),
              ),
            );
          } else {
            return QuestionCard(socialPost[index], context);
          }
        },
        controller: _controller,
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
          _buildListAll(posts),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3A86FF),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InputQuestionModal(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
