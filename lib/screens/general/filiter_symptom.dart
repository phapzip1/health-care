import 'package:flutter/material.dart';
import 'package:health_care/models/symptom_model.dart';

class FilterSymptom extends StatefulWidget {
  final List<SymptomModel> symptom;
  final Function getPosts;
  const FilterSymptom(this.symptom, this.getPosts, {super.key});

  @override
  State<FilterSymptom> createState() => _FilterSymptomState();
}

class _FilterSymptomState extends State<FilterSymptom> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      child: Column(
        children: <Widget>[
          const Text(
            'Filter question base on symptom',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(
            color: Colors.black,
            height: 36,
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Finding symptom',
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
          Expanded(
              child: ListView.builder(
                  itemCount: widget.symptom.length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: TextButton(
                              onPressed: () {
                                widget.getPosts(widget.symptom[index].name);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(50, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                widget.symptom[index].name,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            )),
                        const Divider(
                          color: Colors.black,
                        ),
                      ],
                    );
                  })),
        ],
      ),
    ));
  }
}
