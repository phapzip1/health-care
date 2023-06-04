import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/models/post_model.dart';
import 'package:health_care/widgets/QA_community/input_question_modal.dart';
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

final String formattedDate = DateFormat.yMd().format(DateTime.now());

Widget questionCard(PostModel question, context) {
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
        Text(question.descriptions),
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
                        backgroundImage: NetworkImage(question.doctorImage),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Answered by'),
                          Text(
                            question.doctorName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
            const Row(
              children: [
                Icon(FontAwesomeIcons.comment),
                SizedBox(
                  width: 4,
                ),
                Text('4')
              ],
            ),
          ],
        ),
      ]),
    ),
  );
}

class _CommunityQAState extends State<CommunityQA> {
  bool isLoading = false;
  bool _changedPage = true;
  List<PostModel> posts = [];
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _getMoreData(posts.length);
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getMoreData(posts.length);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _click(value) {
    setState(() {
      _changedPage = value;
    });
  }

  void _getMoreData(int index) async {
    setState(() {
      isLoading = true;
    });

    final newPost = await PostModel.getPublic(index);

    setState(() {
      isLoading = false;
      posts.addAll(newPost);
    });
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
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          headerNavigateSection(_click, _changedPage, mediaQuery),
          _changedPage ? _buildList(posts) : Container(),
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

  Widget _buildList(socialPost) {
    return Expanded(
      child: ListView.builder(
        itemCount: socialPost.length + 1,
        itemBuilder: (context, index) {
          if (index == socialPost.length) {
            return _buildProgressIndicator();
          } else {
            return questionCard(socialPost[index], context);
          }
        },
        controller: _controller,
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
