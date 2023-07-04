import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_state.dart';

class FilterSymptom extends StatefulWidget {
  const FilterSymptom({super.key});

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
            child: BlocBuilder<AppBloc, AppState>(
                // future: SymptomsProvider.getSymtoms(),
                builder: (ctx, state) {
          
                  return ListView.builder(
                      itemCount: state.symptom!.length,
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  state.symptom![index].name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )),
                            const Divider(
                              color: Colors.black,
                            ),
                          ],
                        );
                      });
                }),
          ),
        ],
      ),
    ));
  }
}
