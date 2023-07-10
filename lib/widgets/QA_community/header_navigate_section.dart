// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:health_care/models/symptom_model.dart';
import 'package:health_care/widgets/button_section.dart';

class HeaderNavigateSection extends StatelessWidget {
  final Function click;
  final bool changedPage;
  MediaQueryData mediaQuery;
  TextEditingController searchController;
  final Function openFilterSymptom;
  final List<SymptomModel> symptom;
  HeaderNavigateSection(this.click, this.changedPage, this.mediaQuery,
      this.searchController, this.openFilterSymptom, this.symptom,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => openFilterSymptom(symptom),
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
  }
}
